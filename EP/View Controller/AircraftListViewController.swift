//  AircraftListViewController.swift
import UIKit
class AircraftListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let myArray =  ["First","Second","Third"]
    private var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListTableView()
        
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
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AircraftCell", for: indexPath)
        cell.textLabel?.text = myArray[indexPath.row]
        return cell
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
 

}
