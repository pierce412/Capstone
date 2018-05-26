//
//  UnauthorizedUserViewController.swift
//  EP
//
//  Created by Ray Jex on 5/19/18.
//  Copyright © 2018 verticalendgame. All rights reserved.
//

import UIKit

class UnauthorizedUserViewController: UIViewController {
    
    let unauthorizedView = UnauthorizedInputViews(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(unauthorizedView)
        
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.8
        
        /*let tapGesture = UITapGestureRecognizer(target: self, action: #selector(popUpViewTappedGesture))
        unauthorizedView.popUpView.addGestureRecognizer(tapGesture)*/
    }
    
    @objc func popUpViewTappedGesture() {
        dismiss(animated: true, completion: nil)
    }
}
