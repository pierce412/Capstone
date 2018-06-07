//  SubscriptionViewController.swift

import UIKit
import StoreKit

class SubscriptionViewController: UIViewController {
    let topContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let iapImageView: UIImageView = {
        let image = UIImage(named: "f18")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }() 
    let bottomContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.offWhite()
        return view
    }()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Emergency Procedure Subscription"
        view.textColor = UIColor.offWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .title3)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    let callToActionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Call to action text goes here"
        view.textColor = UIColor.black
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    let termsLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Very convenient for studying Emergency Procedures. All-access to all T/M/S. Offline use included. Interim changes pushed to device. Cancel subsciption at any time. "
        view.numberOfLines = 0
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.textColor = UIColor.mainColorScheme1()
        view.textAlignment = .center
        return view
    }()
    let yearButton: UIButton = {
        let view = UIButton()
        view.setTitle("$19.99 / yr", for: .normal)
        view.setTitleColor(UIColor.offWhite(), for: .normal)
        view.backgroundColor = UIColor.buttonGreen()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.matteBlack().cgColor
        view.addTarget(self, action: #selector(handlePurchaseYear), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let monthButton: UIButton = {
        let view = UIButton()
        view.setTitle("$2.99 / mo", for: .normal)
        view.setTitleColor(UIColor.offWhite(), for: .normal)
        view.backgroundColor = UIColor.buttonGreen()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.matteBlack().cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let sixMonthButton: UIButton = {
        let view = UIButton()
        view.setTitle("$14.99 / 6mo", for: .normal)
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
        view.textAlignment = .right
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let restoreButton: UIButton = {
        let view = UIButton()
        view.setTitle("Restore", for: .normal)
        view.backgroundColor = UIColor.offWhite()
        view.setTitleColor(UIColor.blue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleRestore), for: .touchUpInside)
        return view
    }()
    let restoreStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("Cancel", for: .normal)
        view.setTitleColor(UIColor.offWhite(), for: .normal)
        view.layer.borderColor = UIColor.offWhite().cgColor
        view.layer.borderWidth = 0.3
        view.layer.cornerRadius = 7.0
        view.layer.masksToBounds = true
        view.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let tableView: UITableView = {
        let view = UITableView()
        return view 
    }()
    
    var requestProd = SKProductsRequest()
    var products = [SKProduct]()
    //************************************************************************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        //IAPService.shared.getProducts()
        
        //view.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height - 100)
        //view.backgroundColor = UIColor.offWhite()
        view.addSubview(topContainer)
        view.addSubview(bottomContainer)
        
        topContainer.addSubview(iapImageView)
        topContainer.addSubview(titleLabel)
        topContainer.addSubview(callToActionLabel)
        topContainer.addSubview(termsLabel)
        topContainer.addSubview(cancelButton)
        
        bottomContainer.addSubview(yearButton)
        bottomContainer.addSubview(sixMonthButton)
        bottomContainer.addSubview(monthButton)
        bottomContainer.addSubview(restoreStackView)
        
        
        setupConstraints()
    }
    private func setupStackView() {
        restoreStackView.axis = .horizontal
        restoreStackView.addArrangedSubview(restoreLabel)
        restoreStackView.addArrangedSubview(restoreButton)
        restoreStackView.spacing = 2.0
        restoreStackView.distribution = .fillProportionally
    }
    //MARK: - Private functions
    @objc private func cancelButtonTapped() {
        //print("Cancel button tapped")
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func handlePurchaseYear() {
        //print("handle purchase tapped")
        IAPService.shared.purchase(product: .yearAutoRenewSubscription)
    }
    @objc private func handleRestore() {
        //print("restore button tapped")
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
        topContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topContainer.heightAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        
        bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor).isActive = true
        bottomContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        iapImageView.topAnchor.constraint(equalTo: topContainer.topAnchor).isActive = true
        iapImageView.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor).isActive = true
        iapImageView.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor).isActive = true
        iapImageView.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: topContainer.safeAreaLayoutGuide.topAnchor, constant: 5.0).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -15.0).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 65.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 55.0).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        callToActionLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor).isActive = true
        callToActionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:40.0).isActive = true
        callToActionLabel.widthAnchor.constraint(equalToConstant: topContainer.frame.width - 50).isActive = true
        callToActionLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        termsLabel.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant:-5.0).isActive = true
        termsLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        termsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //********************* BOTTOM CONTAINER ************************************************************
        yearButton.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 20.0).isActive = true
        yearButton.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor).isActive = true
        yearButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        yearButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        sixMonthButton.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor).isActive = true
        sixMonthButton.topAnchor.constraint(equalTo: yearButton.bottomAnchor, constant: 15.0).isActive = true
        sixMonthButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        sixMonthButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        monthButton.topAnchor.constraint(equalTo: sixMonthButton.bottomAnchor, constant: 15.0).isActive = true
        monthButton.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor).isActive = true
        monthButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        monthButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        restoreStackView.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor).isActive = true
        restoreStackView.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor).isActive = true
    }
}

