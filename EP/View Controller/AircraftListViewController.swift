//  AircraftListViewController.swift
import UIKit
import Firebase
import NotificationCenter

class AircraftListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    var isVerified: Bool?
    var aircraft: [Aircraft]?
    let fetcher = ReceiptFetcher()
    
    //*************** Views***************
    let container: UIView = {
        let view = UIView()
        return view
    }()
    let listTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(AircraftCell.self, forCellReuseIdentifier: Constants.AircraftCell)
        return view
    }()
    //*************************************
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /* uncomment to force log someone out - for testing */
        //handleLogout()
        //fetcher.fetchReceipt()
        print("Aircraft List viewDidLoad")
        
        
        // print("Current user: \(Auth.auth().currentUser?.uid) , verified: \(Auth.auth().currentUser?.isEmailVerified)")
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
        }
        else {
            NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
            setupListTableView()
            setupViews()
            //checkAccountStatus()
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(handleLogout))
            guard let isVerified = Auth.auth().currentUser?.isEmailVerified else { return }
            self.title = "Aircraft"
            if(isVerified){
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Subscribe", style: .plain, target: self, action: #selector(handleSubscribe))
            }
//            else {
//                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Manage", style: .plain, target: self, action: #selector(handleAccountManagement))
//            }
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    private func checkAccountStatus() {
        guard let userIsVerified = Auth.auth().currentUser?.isEmailVerified else { return }
        if(!userIsVerified){
            let ua = UnauthorizedUserViewController()
            ua.modalPresentationStyle = .overCurrentContext
            present(ua, animated: true, completion: nil)
        }
    }
    @objc private func handleSubscribe() {
       //print("subscribe button tapped")
       let destinationVC = SubscriptionViewController()
        destinationVC.modalPresentationStyle = .overCurrentContext
        present(destinationVC, animated: true, completion: nil)
        
    }
//    @objc private func handleAccountManagement() {
//        print("Handle manage tappped")
//    }
    
    @objc private func loadList(notification: NSNotification) {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    @objc private func handleLogout() {
        print("Handling logout")
        do {
            try Auth.auth().signOut()
        }
        catch let logoutError  {
            print("Logout error")
            let ac = UIAlertController(title: "Sorry", message: logoutError.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            ac.addAction(okAction)
            self.present(ac, animated: true, completion: nil)
        }
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true, completion: nil)
    }
    
    //MARK: - TableView Methods
    private func setupListTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AircraftController.shared.allAircraft.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AircraftCell, for: indexPath) as! AircraftCell
        let ac = AircraftController.shared.allAircraft[indexPath.row]
        cell.ac = ac
        cell.selectionStyle = .none
        cell.layoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let ac = AircraftController.shared.allAircraft[indexPath.row]
        let destinationVC = EPListViewController()
        destinationVC.ac = ac
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    // MARK: - Constraints
    private func setupViews() {
        view.addSubview(listTableView)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}
