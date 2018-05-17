//  EPListViewController.swift
import UIKit

class EPListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    var ac: Aircraft? 
    var arr = [[EmergencyProcedure]]()
    //*************VIEWS***************************************
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.barTintColor = UIColor.epYellow()
        view.placeholder = "Search EPs"
        return view
    }()
    let tableView: UITableView = {
        let view = UITableView()
        view.register(EPCell.self, forCellReuseIdentifier: Constants.EPCell)
        view.rowHeight = 50
        return view
    }()
    var segControl: UISegmentedControl = {
        let view = UISegmentedControl()
        return view
    }()
    
    let container: UIView = {
        let view = UIView()
        return view
    }()
    //************************************************************
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ac = ac {
            arr = AircraftController.shared.configureAircraftForDisplay(aircraft: ac)
            self.title = "Emergency Procedures"
            segControl = createSegControl()
            segControl.addTarget(self, action: #selector(segValueChanged), for: .valueChanged)
            segControl.selectedSegmentIndex = 0
            setupEpListTableView()
            setupViews()
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationItem.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "EP"
    }
    //MARK: SegmentedControl Method
    @objc func segValueChanged() {
        tableView.reloadData()
        print("Seg value changed: \(segControl.selectedSegmentIndex)")
    }
    //MARK: - TableView Methods
    fileprivate func setupEpListTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr[segControl.selectedSegmentIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.EPCell, for: indexPath) as! EPCell
        let ep = arr[segControl.selectedSegmentIndex][indexPath.row]
        cell.epName = ep.title
        cell.layoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let ep = arr[segControl.selectedSegmentIndex][indexPath.row]
            let destinationVC = EmergencyProcedureViewController()
            destinationVC.ep = ep
            print(ep.shortName)
            navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    //MARK: - Local Functions
    fileprivate func createSegControl() -> UISegmentedControl {
        guard let ac = ac else { return UISegmentedControl() }
        var items = [UIImage]()
        //let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        for (index, _) in ac.categories.enumerated() {
            let stringImage = ac.categories[index]
            let stringImageSelected = stringImage + "_selected"
            if let image = UIImage(named: stringImage) {
               // let selectedImage = UIImage(named: stringImageSelected)
                items.append(image)
            }
        }
        let segToReturn = UISegmentedControl(items: items)
        segToReturn.backgroundColor = UIColor.white
        return segToReturn
    }
    //MARK: - Constraints
    fileprivate func setupViews() {
        view.addSubview(container)
        container.addSubview(searchBar)
        container.addSubview(tableView)
        container.addSubview(segControl)
        
        setContainerConstrains()
        setupSearchBarConstraints()
        setupTableViewConstraints()
        setupSegmentedControlConstraints()
    }
    fileprivate func setContainerConstrains(){
        
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
    fileprivate func setupSearchBarConstraints() {
        searchBar.anchor(top: container.topAnchor,
                         left: container.leftAnchor,
                         bottom: nil,
                         right: container.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: 0)
    }
    fileprivate func setupTableViewConstraints() {
        tableView.anchor(top: searchBar.bottomAnchor,
                         left: container.leftAnchor,
                         bottom: segControl.topAnchor,
                         right: container.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: 0)
    }
    fileprivate func setupSegmentedControlConstraints() {
        segControl.anchor(top: tableView.bottomAnchor,
                          left: container.leftAnchor,
                          bottom: container.bottomAnchor,
                          right: container.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 45)
    }
}
