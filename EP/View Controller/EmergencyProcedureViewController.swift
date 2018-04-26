//  EmergencyProcedureViewController.swift
import UIKit

class EmergencyProcedureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let testArr = ["Test", "Test", "Test", "Test", "Test"]
    //container for EP passed in
    var ep: EmergencyProcedure?
    
    private var epTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpTableView()
    }
    //MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath)
        cell.textLabel?.text = testArr[indexPath.row]
        return cell
    }
    fileprivate func setupEpTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        epTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        epTableView.register(UITableViewCell.self, forCellReuseIdentifier: "StepCell")
        epTableView.delegate = self
        epTableView.dataSource = self
        self.view.addSubview(epTableView)
    }
}
