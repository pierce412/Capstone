//  LogicCell.swift

import UIKit
class LogicCell: UITableViewCell {
    var step: String?
    
    var logicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.italicSystemFont(ofSize: 16)
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(logicLabel)
        logicLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        logicLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        logicLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        logicLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            logicLabel.text = step
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
