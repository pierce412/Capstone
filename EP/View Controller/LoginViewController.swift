//  ViewController.swift
import UIKit
class LoginViewController: UIViewController {
    //MARK: - Properties
    //****************************** VIEWS ********************************
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a valid @navy.mil or @usmc.mil email address."
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.autocapitalizationType = .none
        return tf
    }()
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red:  149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    //**********************************************************************
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(instructionLabel)
        view.addSubview(emailTextField)
        view.addSubview(submitButton)
        setupConstraints()
    }
    //MARK: - Local Functions
    @objc func submitButtonTapped() {
        navigationController?.pushViewController(AircraftListViewController(), animated: true)
    }
    //MARK: - Constraints
    fileprivate func setupConstraints() {
        instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        instructionLabel.anchor(top: nil,
                                left: nil,
                                bottom: emailTextField.topAnchor,
                                right: nil,
                                paddingTop: 0,
                                paddingLeft: 0,
                                paddingBottom:-20,
                                paddingRight: 0,
                                width: 0,
                                height: 0)
        
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailTextField.anchor(top: nil,
                              left: view.leftAnchor,
                              bottom: nil,
                              right: view.rightAnchor,
                              paddingTop: 0,
                              paddingLeft: 20,
                              paddingBottom: 0,
                              paddingRight: 20,
                              width: view.frame.width / 1.2,
                              height: 45)
        
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitButton.anchor(top: emailTextField.bottomAnchor,
                            left: view.leftAnchor,
                            bottom: nil,
                            right: view.rightAnchor,
                            paddingTop: 20,
                            paddingLeft: 20,
                            paddingBottom: 0,
                            paddingRight: 20,
                            width: view.frame.width / 1.2,
                            height: 45)
        
    }
}

