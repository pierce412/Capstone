//  AircraftListViewController.swift
import UIKit
import Firebase
import NotificationCenter

class AircraftListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    var isVerified: Bool?
    var aircraft: [Aircraft]?
  
    //*************** Views***************
    let container: UIView = {
        let view = UIView()
        return view
    }()
    let listTableView: UITableView = {
        let view = UITableView()
        view.register(AircraftCell.self, forCellReuseIdentifier: Constants.AircraftCell)
        return view
    }()
    //*************************************
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //notification to reload
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        print("current user uid is: \(Auth.auth().currentUser?.uid)")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(handleLogout))
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
        }
        //guard let isVerified = Auth.auth().currentUser?.isEmailVerified else { return }
        setupListTableView()
        setupViews()
        self.title = String(describing: isVerified)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.setRightBarButton(addButton, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationItem.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "EP"
    }
    
    @objc fileprivate func loadList(notification: NSNotification) {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
        
    }
    @objc fileprivate func handleLogout() {
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
    
    @objc fileprivate func addButtonTapped() {
        print("Add button tapped")
        navigationController?.pushViewController(AddAircraftViewController(), animated: true)
    }
 
    //MARK: - TableView Methods
    fileprivate func setupListTableView() {
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
        cell.layoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let ac = AircraftController.shared.allAircraft[indexPath.row]
        let destinationVC = EPListViewController()
        destinationVC.ac = ac
        //destinationVC.categories = ac.categories
        print("Destination A/C is  \(ac.tmsID)")
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    // MARK: - Constraints
    fileprivate func setupViews() {
        view.addSubview(container)
        container.addSubview(listTableView)
        setContainerConstraints()
        setupTableViewConstraints()
    }
    fileprivate func setContainerConstraints(){
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0, height: 0)
    }
    
    fileprivate func setupTableViewConstraints() {
        listTableView.anchor(top: container.topAnchor,
                         left: container.leftAnchor,
                         bottom: container.bottomAnchor,
                         right: container.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: 0)
    }
}
