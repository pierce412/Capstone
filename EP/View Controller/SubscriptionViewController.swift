//  SubscriptionViewController.swift

import UIKit
import StoreKit

class SubscriptionViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Emergency Procedure Subscription"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .title2)
        view.numberOfLines = 2
        view.textAlignment = .center
        return view
    }()
    let callToActionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Call to action text goes here"
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    let termsLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Terms go here"
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.textAlignment = .center
        return view
    }()
//    let transactionButtonContainer: UIView = {
//        let view = UILabel()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    let yearButton: UIButton = {
        let view = UIButton()
        view.setTitle("$19.99/yr", for: .normal)
        view.setTitleColor(UIColor.offWhite(), for: .normal)
        view.backgroundColor = UIColor.buttonGreen()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.matteBlack().cgColor
        view.addTarget(self, action: #selector(handlePurchase), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let monthButton: UIButton = {
        let view = UIButton()
        view.setTitle("$1.99/mo", for: .normal)
        view.setTitleColor(UIColor.offWhite(), for: .normal)
        view.backgroundColor = UIColor.buttonGreen()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.matteBlack().cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let restoreLabel: UILabel = {
        let view = UILabel()
        view.text = "Already Purchased?"
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let restoreButton: UIButton = {
        let view = UIButton()
        view.setTitle("Restore", for: .normal)
        view.backgroundColor = UIColor.offWhite()
        view.setTitleColor(UIColor.matteBlack(), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("Cancel", for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        view.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var requestProd = SKProductsRequest()
    var products = [SKProduct]()
    //************************************************************************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        IAPService.shared.getProducts()

        
        view.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height - 100)
        view.backgroundColor = UIColor.offWhite()
        
        view.addSubview(titleLabel)
        view.addSubview(callToActionLabel)
        view.addSubview(termsLabel)
        view.addSubview(yearButton)
        view.addSubview(monthButton)
        view.addSubview(restoreLabel)
        view.addSubview(restoreButton)
        view.addSubview(cancelButton)

        setupConstraints()
    }
    //MARK: - Private functions
        @objc private func cancelButtonTapped() {
            print("Cancel button tapped")
            self.dismiss(animated: true, completion: nil)
        }
    @objc private func handlePurchase() {
        print("handle purchase tapped")
        IAPService.shared.purchase(product: .yearAutoRenewSubscription)
    }
//    func setPrices() {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        let productYear = IAPService.shared.products[0].
//        formatter.locale = productYear.priceLocale
//        let priceString = formatter.string(from: productYear.price)
//        yearButton.setTitle(priceString, for: .normal)
//    }
    //MARK: - Constraints *************************************************************************************************************************
    private func setupConstraints(){
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70.0).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        callToActionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callToActionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25.0).isActive = true
        callToActionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        callToActionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        termsLabel.topAnchor.constraint(equalTo: callToActionLabel.bottomAnchor, constant: 25.0).isActive = true
        termsLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        termsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        yearButton.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 30.0).isActive = true
        yearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/5).isActive = true
        yearButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        yearButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        monthButton.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 30.0).isActive = true
        monthButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/5).isActive = true
        monthButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        monthButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        restoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restoreLabel.bottomAnchor.constraint(equalTo: restoreButton.topAnchor, constant: -40.0).isActive = true
        //restoreLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //restoreLabel.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        restoreButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40.0).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 65.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        

    }
}

