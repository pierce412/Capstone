//  CautionCell.swift

import UIKit
class CautionCell: UITableViewCell {
    var step: String?
    
    var cautionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .justified
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(cautionLabel)
        cautionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cautionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cautionLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cautionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            cautionLabel.text = step
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

