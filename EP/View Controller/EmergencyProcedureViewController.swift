//  EmergencyProcedureViewController.swift
import UIKit
class EmergencyProcedureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: - Properties
    var ep: EmergencyProcedure?
    private var epTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpTableView()
        epTableView.allowsSelection = false
        if ep != nil {
            self.title = "EP VC"
        }
    }
    //MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ep = ep else { return 0 }
        return ep.steps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath)
        guard let ep = ep else { return UITableViewCell() }
        cell.textLabel?.text = ep.steps[indexPath.row].step
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
