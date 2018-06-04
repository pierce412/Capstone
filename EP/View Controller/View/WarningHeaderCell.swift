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
        if step != nil {
            
            contentView.addSubview(warningImageView)
            //let marginGuide = contentView.layoutMarginsGuide

            
            warningImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            warningImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            warningImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            warningImageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
