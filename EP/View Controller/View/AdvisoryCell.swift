//
//  AdvisoryCell.swift

import UIKit
class AdvisoryCell: UITableViewCell {
    var step: String?
    
    var advisoryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(advisoryLabel)
        advisoryLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        advisoryLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        advisoryLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        advisoryLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            advisoryLabel.text = step
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
