//  NoteHeaderCell.swift

import UIKit
import QuartzCore

class NoteHeaderCell: UITableViewCell {
    var step: String?
    
    var headerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        view.textAlignment = .center
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if step != nil {
            contentView.addSubview(headerLabel)
            //let marginGuide = contentView.layoutMarginsGuide
            headerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            //headerLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            //headerLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            //headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
            //headerLabel.heightAnchor.constraint(equalToConstant: 27.5).isActive = true
            
            headerLabel.text = "Note"
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
