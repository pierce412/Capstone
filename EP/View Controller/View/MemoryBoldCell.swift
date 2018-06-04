//
//  MemoryBoldCell.swift
//  EP
import UIKit
class MemoryBoldCell: UITableViewCell {
    var step: String?
    
    var memoryBoldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(memoryBoldLabel)
        memoryBoldLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        memoryBoldLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        memoryBoldLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        memoryBoldLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            memoryBoldLabel.text = step
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
