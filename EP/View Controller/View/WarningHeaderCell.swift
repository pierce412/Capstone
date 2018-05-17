//  WarningHeaderCell.swift

import UIKit
import QuartzCore

class WarningHeaderCell: UITableViewCell {
    var step: String?
    
//    var headerLabel: UILabel = {
//        let view = UILabel()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        view.textAlignment = .center
//        return view
//    }()
    var warningImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "warningHeaderImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let step = step {
            
            contentView.addSubview(warningImageView)
            let marginGuide = contentView.layoutMarginsGuide
//            headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//            headerLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
//            headerLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
//            headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
//            headerLabel.heightAnchor.constraint(equalToConstant: 27.5).isActive = true
//            headerLabel.text = "WARNING"
//            headerLabel.layer.borderColor = UIColor.black.cgColor
//            headerLabel.layer.borderWidth = 2.5
//            headerLabel.layer.masksToBounds = true
            
            warningImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            warningImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            warningImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            warningImageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            //headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
            //headerLabel.heightAnchor.constraint(equalToConstant: 27.5).isActive = true
            //headerLabel.text = "WARNING"
            //headerLabel.layer.borderColor = UIColor.black.cgColor
            //headerLabel.layer.borderWidth = 2.5
            //headerLabel.layer.masksToBounds = true
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
