//
//  IAPService.swift
//  EP
//
//  Created by Ray Jex on 5/26/18.
//  Copyright © 2018 verticalendgame. All rights reserved.
//

import UIKit
import StoreKit

class IAPService: NSObject {
    private override init()  { }
    static let shared = IAPService()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
   
    //return available products
    func getProducts() {
        let products: Set = [IAPProduct.yearAutoRenewSubscription.rawValue]
        
        //create request for available products
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        //set this class to be the observer of the payment queue
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue}).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
}

//You can add some code in the productsRequest(didReceive response) method so that it posts a notification or calls a delegate once the response is equal to purchased﻿
extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
//        print("Product count is: \(products.count)")
//        print(products[0].localizedDescription)
        
    }
}
//allows monitoring of the transaction queue
extension IAPService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState)
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
        }
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
