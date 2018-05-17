//  MemoryCell.swift
import UIKit
class MemoryCell: UITableViewCell {
    var step: String?
    
    var memoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(memoryLabel)
        memoryLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        memoryLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        memoryLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        memoryLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            memoryLabel.text = step
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

