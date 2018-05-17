//  NonMemoryCell.swift

import UIKit
class NonMemoryCell: UITableViewCell {
    var step: String?
    
    var nonMemoryLabel: UILabel = {
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
        
        contentView.addSubview(nonMemoryLabel)
        nonMemoryLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15).isActive = true
        nonMemoryLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nonMemoryLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nonMemoryLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            nonMemoryLabel.text = step
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
