//  ScrollViewController.swift
import UIKit

class ScrollViewController: UIViewController {
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        return sb
    }()
    weak var pageControl: UIPageControl! = {
        let pc = UIPageControl()
        return pc
    }()
    weak var scrollView: UIScrollView! = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.contentSize = CGSize(width: sv.contentSize.width, height: sv.frame.size.height)
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        return label
    }()
    
    var tableViews = [TableScrollViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let warningsTableView = setUpTableViews()
        let cautionsTableView = setUpTableViews()
        let advisoriesTableView = setUpTableViews()
        let flightTableView = setUpTableViews()
        let groundTableView = setUpTableViews()
        
        scrollView.delegate = self
        
        
        
        warningsTableView.view.backgroundColor = UIColor.blue
        cautionsTableView.view.backgroundColor = UIColor.yellow
        advisoriesTableView.view.backgroundColor = UIColor.purple
        flightTableView.view.backgroundColor = UIColor.red
        groundTableView.view.backgroundColor = UIColor.orange
        
        tableViews = [warningsTableView, cautionsTableView, advisoriesTableView, flightTableView, groundTableView]
        
        let views: [String: UIView] = ["view": view,
                                       "warningsTableView": warningsTableView.view,
                                       "cautionsTableView": cautionsTableView.view,
                                       "advisoriesTableView": advisoriesTableView.view,
                                       "flightTableView": flightTableView.view,
                                       "groundTableView": groundTableView.view]
        let metrics = ["edgeMargin":10, "betweenMargin":20]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[tableView1(==view)]-100-|", options: [], metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-edgeMargin-[tableView1(==view)]-betweenMargin-[tableView2(==view)]-betweenMargin-[tableView3(==view)]-betweenMargin-[tableView4(==view)]-betweenMargin-[tableView5(==view)]-edgeMargin-|", options: [.alignAllTop, .alignAllBottom], metrics: metrics, views: views)
        NSLayoutConstraint.activate(verticalConstraints + horizontalConstraints)
    }
    // MARK: - Private Functions
    private func setUpTableViews() -> TableScrollViewController {
        let tableView = TableScrollViewController()
        tableView.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(tableView.view)
        //scrollView.addSubview(categoryLabel)
        addChildViewController(tableView)
        tableView.didMove(toParentViewController: self)
        return tableView
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageFraction = scrollView.contentOffset.x / pageWidth
        pageControl.currentPage = Int(round(pageFraction))
        
        switch pageControl.currentPage {
        case 0: categoryLabel.text = "Warnings"
        case 1: categoryLabel.text = "Cautions"
        case 2: categoryLabel.text = "Advisories"
        case 3: categoryLabel.text = "In Flight"
        case 4: categoryLabel.text = "Ground"
        default: categoryLabel.text = "Default"
        }
    }
}
