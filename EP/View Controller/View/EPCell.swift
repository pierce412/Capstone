//  EPCell.swift

import UIKit
class EPCell: UITableViewCell {
    var epName: String?
    
    var epLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(epLabel)
        epLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        epLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        epLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        epLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let epName = epName {
            epLabel.text = epName
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
