//  AddAircraftViewController.swift


import UIKit

class AddAircraftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let testArray = ["V-22 Osprey","CH-53 Super Stallion","AH-1Y Huey"]
    private var addTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTableView() 
    }
    fileprivate func setupAddTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        addTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        addTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AddAircraftCell")
        addTableView.delegate = self
        addTableView.dataSource = self
        self.view.addSubview(addTableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addTableView.dequeueReusableCell(withIdentifier: "AddAircraftCell", for: indexPath)
        cell.textLabel?.text = testArray[indexPath.row]
        return cell
    }
}
