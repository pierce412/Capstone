//  AircraftListViewController.swift
import UIKit
import Firebase
import NotificationCenter

class AircraftListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    var isVerified: Bool?
    var aircraft: [Aircraft]?
    private var listTableView: UITableView!
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        //notification to reload tableView
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        print("current user uid is: \(Auth.auth().currentUser?.uid)")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(handleLogout))
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
        }
        //guard let isVerified = Auth.auth().currentUser?.isEmailVerified else { return }
        setupListTableView()
        self.title = String(describing: isVerified)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.setRightBarButton(addButton, animated: true)
//        self.navigationItem.leftBarButtonItem?.isEnabled = false
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
    fileprivate func setupListTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        listTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AircraftCell")
        listTableView.delegate = self
        listTableView.dataSource = self
        self.view.addSubview(listTableView)
    }
    //MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AircraftController.shared.allAircraft.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AircraftCell", for: indexPath)
        let ac = AircraftController.shared.allAircraft[indexPath.row]
        cell.textLabel?.text = ac.tmsName
        cell.detailTextLabel?.text = ac.tmsID
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
}
