//  GeneralCell.swift

import UIKit
class GeneralCell: UITableViewCell {
    var step: String?
    
    var generalLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.preferredFont(forTextStyle: .callout)
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(generalLabel)
        generalLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        generalLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        generalLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        generalLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            generalLabel.text = step
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
