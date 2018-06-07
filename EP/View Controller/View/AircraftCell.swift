//  AircraftCell.swift

import UIKit
class AircraftCell: UITableViewCell {
    var ac: Aircraft?
    
    var acLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.preferredFont(forTextStyle: .title3)
        return view
    }()
    var tmsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var interimChangeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return view
    }()
    var interimChangeDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .caption2)
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(tmsImageView)
        let stackView = UIStackView(arrangedSubviews: [acLabel, interimChangeLabel, interimChangeDateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        tmsImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        tmsImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        tmsImageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        tmsImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: tmsImageView.rightAnchor, constant: 15).isActive = true
        stackView.rightAnchor.constraint(equalTo: marginGuide.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if let ac = ac {
            //print(ac.aircraftIconImageName)
            tmsImageView.image = UIImage(named: ac.aircraftIconImageName)
            acLabel.text = ac.tmsName
            acLabel.textColor = UIColor.matteBlack()
            interimChangeLabel.text = ac.interimChangeID
            interimChangeDateLabel.text = ac.interimChangeDate
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
