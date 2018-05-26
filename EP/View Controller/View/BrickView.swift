//  BrickView.swift
//  EP

import UIKit
class UnauthorizedInputViews: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let popUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.alpha = 1.0
        return view
    }()
    
    let unauthorizedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please check inbox for authentication link."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let checkMarkImage: UIImageView = {
        let checkMark = UIImageView(image: #imageLiteral(resourceName: "x"))
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        checkMark.layer.cornerRadius = checkMark.frame.width / 30
        return checkMark
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(popUpView)
        popUpView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        popUpView.widthAnchor.constraint(equalToConstant: frame.width * 0.6).isActive = true
        popUpView.heightAnchor.constraint(equalToConstant: frame.height * 0.3).isActive = true
        
        popUpView.addSubview(unauthorizedLabel)
        unauthorizedLabel.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor).isActive = true
        unauthorizedLabel.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 80).isActive = true
        unauthorizedLabel.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor).isActive = true
        
        popUpView.addSubview(checkMarkImage)
        checkMarkImage.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor).isActive = true
        checkMarkImage.topAnchor.constraint(equalTo: unauthorizedLabel.bottomAnchor, constant: 30).isActive = true
        checkMarkImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        checkMarkImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
