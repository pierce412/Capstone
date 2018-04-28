//  AircraftListViewController.swift
import UIKit
class AircraftListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    var aircraft: [Aircraft]?
    private var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListTableView()
        self.title = "AircraftList"
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
