//  EPListViewController.swift
import UIKit

class EPListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate {
  
    
    //MARK: - Properties
    var ac: Aircraft? 
    var arr = [[EmergencyProcedure]]()
    var filteredEPs = [EmergencyProcedure]()
    var sectionArray: [EmergencyProcedure] = []
    let searchController = UISearchController(searchResultsController: nil)

    let tableView: UITableView = {
        let view = UITableView()
        view.register(EPCell.self, forCellReuseIdentifier: Constants.EPCell)
        view.rowHeight = 50
        return view
    }()
    var segControl: UISegmentedControl!
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        if let ac = ac {
            
            arr = AircraftController.shared.configureAircraftForDisplay(aircraft: ac)
            self.title = "Emergency Procedures"
            segControl = createSegControl()
            segControl.addTarget(self, action: #selector(segValueChanged), for: .valueChanged)
            segControl.selectedSegmentIndex = 0
            sectionArray = arr[segControl.selectedSegmentIndex]
            for ep in sectionArray {
                print(ep.title)
            }
            setupEpListTableView()
            setupViews()
           
            self.navigationItem.title = ac.categories[segControl.selectedSegmentIndex]
        }
    }
    private func configureSearchBar() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search EPs"
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor.offWhite()
        searchController.searchBar.barStyle = .blackTranslucent
        //searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
    }
    //MARK: SegmentedControl Method
    @objc func segValueChanged() {
        sectionArray = arr[segControl.selectedSegmentIndex]
        tableView.reloadData()
        print("Seg value changed: \(segControl.selectedSegmentIndex)")
        guard let ac = ac else { return }
        self.navigationItem.title = ac.categories[segControl.selectedSegmentIndex]
    }
    //MARK: - TableView Methods
    private func setupEpListTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredEPs.count
        }
        else {
            return sectionArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.EPCell, for: indexPath) as! EPCell
        let ep: EmergencyProcedure
        if isFiltering() {
            ep = filteredEPs[indexPath.row]
        }
        else {
            ep = sectionArray[indexPath.row]
        }
        cell.epName = ep.title
        cell.selectionStyle = .none
        cell.layoutSubviews()
        return cell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ep: EmergencyProcedure
        if(isFiltering()){
            ep = filteredEPs[indexPath.row]
        }
        else {
            ep = sectionArray[indexPath.row]
        }
        let destinationVC = EmergencyProcedureViewController()
        destinationVC.ep = ep
        print(ep.shortName)
        navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    //MARK: - Local Functions
    private func createSegControl() -> UISegmentedControl {
        guard let ac = ac else { return UISegmentedControl() }
        var items = [UIImage]()
        //let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        for (index, _) in ac.categories.enumerated() {
            let stringImage = ac.categories[index]
           
            //let stringImageSelected = stringImage + "_selected"
            if let image = UIImage(named: stringImage) {
                items.append(image)
            }
        }
        let segToReturn = UISegmentedControl(items: items)
        segToReturn.isMomentary = false
        segToReturn.tintColor = UIColor.offWhite()
        segToReturn.backgroundColor = UIColor.mainColorScheme1()
        return segToReturn
    }
    // MARK: - Private instance methods
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredEPs = sectionArray.filter({( ep : EmergencyProcedure) -> Bool in
            return ep.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    //MARK: - Constraints
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(segControl)
        setupTableViewConstraints()
        setupSegmentedControlConstraints()
    }

    private func setupTableViewConstraints() {
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: segControl.topAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: 0)
    }
    private func setupSegmentedControlConstraints() {
        segControl.anchor(top: tableView.bottomAnchor,
                          left: view.leftAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          right: view.rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0, height: 45)
    }
}

extension EPListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
