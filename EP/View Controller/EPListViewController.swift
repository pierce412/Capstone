//  EPListViewController.swift
import UIKit

class EPListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Properties
    var ac: Aircraft? 
    var arr = [[EmergencyProcedure]]()
    //*************VIEWS***************************************
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    let tableView: UITableView = {
        let view = UITableView()
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
            //print("Here be 2D arrrrr")
            //print(arr)
            self.title = "EP List"
            segControl = createSegControl()
            segControl.addTarget(self, action: #selector(segValueChanged), for: .valueChanged)
            segControl.selectedSegmentIndex = 0
            setupEpListTableView()
            setupViews()
        }
        //print("There are \(ac?.emergencyProcedures.count) EPs from \(ac?.tmsID)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //tableView.reloadData()
    }
    //MARK: SegmentedControl Method
    @objc func segValueChanged() {
        tableView.reloadData()
        print("Seg value changed: \(segControl.selectedSegmentIndex)")
    }
    //MARK: - TableView Methods
    fileprivate func setupEpListTableView() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EPCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returns the num rows in selected section (segmentedControl)
        //print("Is this changing: \(arr[segControl.selectedSegmentIndex].count)")
        return arr[segControl.selectedSegmentIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EPCell", for: indexPath)
        let ep = arr[segControl.selectedSegmentIndex][indexPath.row]
        cell.textLabel?.text = ep.title
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
        segToReturn.backgroundColor = UIColor.mainSchemeColor2()
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
