//  ManageViewController.swift

import UIKit
import StoreKit

class ManageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        let view = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "ManageCell")
       
        return view
    }()
    let subTitles = ["All access (1 year) - billed annually","All access (6 months) - billed semi-annually","All access (1 month) - billed monthly"]
    let subPrices = ["$19.99","$14.99","$2.99"]
    let sectionTitles = ["YOUR SUBSCRIPTION","OPTIONS",""]
    let numRows = [1,3,1]
    let reuseIdentifier = "ManageCell"
    
    var requestProd = SKProductsRequest()
    var products = [SKProduct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.addSubview(tableView)
        setupConstraints()
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) { return "YOUR SUBSCRIPTION" }
        else if (section == 1) { return "OPTIONS" }
        else { return "" }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) { return 1 }
        else if (section == 1) { return 3 }
        else { return 1 }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as UITableViewCell
        if(indexPath.section == 0) {
            let image = UIImage(named: "default")
            let imageView1 = UIImageView(image: image)
            cell.textLabel?.text = "My current subscription"
        }
        
        if(indexPath.section == 1){
            cell.textLabel?.text = subTitles[indexPath.row]
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
            cell.detailTextLabel?.text = subPrices[indexPath.row]
        }
        else if (indexPath.section == 2) {
            cell.textLabel?.text = "Cancel Subscription"
            cell.textLabel?.textColor = UIColor.red
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }
    //    func setPrices() {
    //        let formatter = NumberFormatter()
    //        formatter.numberStyle = .currency
    //        let productYear = IAPService.shared.products[0].
    //        formatter.locale = productYear.priceLocale
    //        let priceString = formatter.string(from: productYear.price)
    //        yearButton.setTitle(priceString, for: .normal)
    //    }
    //MARK: - Constraints
    private func setupConstraints(){
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}


