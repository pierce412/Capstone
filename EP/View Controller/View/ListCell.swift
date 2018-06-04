//  ListCell.swift

import UIKit
class ListCell: UITableViewCell {
    var step: String?
    
    var listLabel: UILabel = {
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
        contentView.addSubview(listLabel)
        listLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 20).isActive = true
        listLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 20).isActive = true
        listLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        listLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            listLabel.text = step
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
