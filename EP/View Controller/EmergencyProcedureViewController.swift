//  EmergencyProcedureViewController.swift
import UIKit
class EmergencyProcedureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: - Properties
    var ep: EmergencyProcedure?
    
    //MARK: - Views
    //*******************************************************
    let container: UIView = {
        let view = UIView()
        return view
    }()
    let epTableView: UITableView = {
        let view = UITableView()
        //view.estimatedRowHeight = 100
        //view.rowHeight = UITableViewAutomaticDimension
        view.register(NonMemoryCell.self, forCellReuseIdentifier: Constants.NonMemoryCell)
        view.register(MemoryCell.self, forCellReuseIdentifier: Constants.MemoryCell)
        view.register(LogicCell.self, forCellReuseIdentifier: Constants.LogicCell)
        view.register(MemoryBoldCell.self, forCellReuseIdentifier: Constants.MemoryBoldCell)
        view.register(WarningCell.self, forCellReuseIdentifier: Constants.WarningCell)
        view.register(CautionCell.self, forCellReuseIdentifier: Constants.CautionCell)
        view.register(NoteCell.self, forCellReuseIdentifier: Constants.NoteCell)
        view.register(AdvisoryCell.self, forCellReuseIdentifier: Constants.AdvisoryCell)
        view.register(GeneralCell.self, forCellReuseIdentifier: Constants.GeneralCell)
        view.register(ListCell.self, forCellReuseIdentifier: Constants.ListCell)
        view.register(TitleCell.self, forCellReuseIdentifier: Constants.TitleCell)
        view.register(WarningHeaderCell.self, forCellReuseIdentifier: Constants.WarningHeaderCell)
        view.register(CautionHeaderCell.self, forCellReuseIdentifier: Constants.CautionHeaderCell)
        view.register(NoteHeaderCell.self, forCellReuseIdentifier: Constants.NoteHeaderCell)

        view.allowsSelection = false
        view.separatorStyle = .none
        return view
    }()
    //*******************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEpTableView()
        setupViews()
        self.title = "EP"
        epTableView.estimatedRowHeight = 100
        epTableView.rowHeight = UITableViewAutomaticDimension
    }
    //MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ep = ep else { return 0 }
        return ep.steps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ep = ep else { return UITableViewCell() }
        let step = ep.steps[indexPath.row]
        
        switch(step.type){
        case .nonMemory:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NonMemoryCell, for: indexPath) as! NonMemoryCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
        case .memory:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MemoryCell, for: indexPath) as! MemoryCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
        case .logic:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.LogicCell, for: indexPath) as! LogicCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
        case .memoryBold:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MemoryBoldCell, for: indexPath) as! MemoryBoldCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
        case .warning:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WarningCell, for: indexPath) as! WarningCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
        case .caution:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CautionCell, for: indexPath) as! CautionCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        case .note:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NoteCell, for: indexPath) as! NoteCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        case .advisory:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.AdvisoryCell, for: indexPath) as! AdvisoryCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        case .general:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GeneralCell, for: indexPath) as! GeneralCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        case .list:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ListCell, for: indexPath) as! ListCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TitleCell, for: indexPath) as! TitleCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        case .headerWarning:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WarningHeaderCell, for: indexPath) as! WarningHeaderCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        case .headerCaution:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CautionHeaderCell, for: indexPath) as! CautionHeaderCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
        
        case .headerNote:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NoteHeaderCell, for: indexPath) as! NoteHeaderCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NonMemoryCell, for: indexPath) as! NonMemoryCell
            cell.step = step.step
            cell.layoutSubviews()
            return cell
            
        }
        
    }
    fileprivate func setupEpTableView() {
        epTableView.delegate = self
        epTableView.dataSource = self
    }
    // MARK: - Constraints
    fileprivate func setupViews() {
        view.addSubview(container)
        container.addSubview(epTableView)
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
        epTableView.anchor(top: container.topAnchor,
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
