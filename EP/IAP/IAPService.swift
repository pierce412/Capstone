//  IAPService.swift

import UIKit
import StoreKit

class IAPService: NSObject {
    override init()  { }
    static let shared = IAPService()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    //return available products
    func getProducts() {
        let products: Set = [IAPProduct.yearAutoRenewSubscription.rawValue, IAPProduct.sixMonthAutoRenewSubscription.rawValue, IAPProduct.monthAutoRenewSubscription.rawValue]
        
        //create request for available products
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        //set this class to be the observer of the payment queue
        //paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue}).first else { return }
        let payment = SKPayment(product: productToPurchase)
        //TODO: - 
        //apple is requesting this step to help detect fraud
        //payment.applicationUsername = hash(yourCustomerAccountName)
        paymentQueue.add(payment)
    }
}

//You can add some code in the productsRequest(didReceive response) method so that it posts a notification or calls a delegate once the response is equal to purchased﻿
extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        print("Product count is: \(products.count)")
        for product in response.products {
            print("Product: \(product.productIdentifier)")
        }
        
    }
}
//allows monitoring of the transaction queue
extension IAPService: SKPaymentTransactionObserver, SKRequestDelegate {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            //print(transaction.transactionState)
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            switch (transaction.transactionState) {
            case .deferred: handleDeferredState(for: transaction, in: queue)
            case .failed:  handleFailedState(for: transaction, in: queue)
            case .purchasing: handlePurchasingState(for: transaction, in: queue)
            case .purchased: handlePurchasedState(for: transaction, in: queue)
            case .restored: handleRestoredState(for: transaction, in: queue)
            }
        }
    }
    func handlePurchasingState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("User is attempting to purchase product id: \(transaction.payment.productIdentifier)")
    }
    
    func handlePurchasedState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("User purchased product id: \(transaction.payment.productIdentifier)")
        let receiptValidator = ReceiptValidator()
        let receiptRequest = SKReceiptRefreshRequest()
        receiptRequest.delegate = self
        let validationResult = receiptValidator.validateReceipt()
        switch validationResult {
        case .success:
            print("A good receipt was processed")
            AircraftController.shared.saveToPersistentStorage()
            
        case .error(let error):
            print(error)
            receiptRequest.start()
        }
    }
    
    func handleRestoredState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("Purchase restored for product id: \(transaction.payment.productIdentifier)")
    }
    
    func handleFailedState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("Purchase failed for product id: \(transaction.payment.productIdentifier)")
    }
    
    func handleDeferredState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("Purchase deferred for product id: \(transaction.payment.productIdentifier)")
    }
    
    func requestDidFinish(_ request: SKRequest) {
        print("Request did finish")
        //        do {
        //            //try receiptValidator.validateReceipt()
        //        } catch {
        //            // Log unsuccessful attempt and optionally begin grace period
        //            // before disabling app functionality, or simply disable features
        //        }
    }
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail with error")
        print(error.localizedDescription)
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}

//HOW TO:

//finish a transaction
//SKPaymentQueue.default().finishTransaction(transaction)
// if you don't remove it, the first thing it will do the next time it launches it will go through everything all over again

//restore completed transactions
//SKPaymentQueue.default().restoreCompletedTransactions()

//adds the completed active purchases back to the queue and follows the same steps as if it were just purchased
//additional callbacks
// paymentQueueRestoreCompletedTransactionsFinished
// restoreCompletedTransactionsFailedWithError



