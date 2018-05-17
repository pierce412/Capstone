//  CautionHeaderCell.swift

import UIKit
import QuartzCore

class CautionHeaderCell: UITableViewCell {
    var step: String?
    
    var cautionImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "cautionHeaderImage")
        return view
    }()
//    var headerLabel: UILabel = {
//        let view = UILabel()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        view.textAlignment = .center
//        return view
//    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if step != nil {
            contentView.addSubview(cautionImageView)
            let marginGuide = contentView.layoutMarginsGuide
            
            cautionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            cautionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            cautionImageView.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
            cautionImageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            
            
            //            headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            //            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            //            headerLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            //            headerLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            //            headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
            //            headerLabel.heightAnchor.constraint(equalToConstant: 27.5).isActive = true
            //
            //            headerLabel.text = "CAUTION"
            //            headerLabel.layer.borderColor = UIColor.black.cgColor
            //            headerLabel.layer.borderWidth = 2.5
            //            headerLabel.layer.cornerRadius = 6
            //            headerLabel.layer.masksToBounds = true
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
