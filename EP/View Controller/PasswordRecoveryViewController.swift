//  PasswordRecovery.swift
import UIKit
import Firebase

class PasswordRecoveryViewController: UIViewController {
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("Cancel", for: .normal)
        view.setTitleColor(UIColor.offWhite(), for: .normal)
        view.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.offWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    let passwordRecoveryTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        view.autocapitalizationType = .none
        view.clearButtonMode = .whileEditing
        view.placeholder = "Email"
        return view
    }()
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ap256")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var passwordRecoveryButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.backgroundColor = UIColor.barGray()
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSendPasswordRecoveryEmail), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(inputsContainerView)
        view.addSubview(logoImageView)
        view.addSubview(passwordRecoveryButton)
        view.addSubview(cancelButton)
        
        inputsContainerView.addSubview(passwordRecoveryTextField)
        setupConstraints()
        view.backgroundColor = UIColor.mainColorScheme1()
    }
    @objc private func handleSendPasswordRecoveryEmail() {
        guard let email = passwordRecoveryTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                let ac = UIAlertController(title: "Sorry!", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                ac.addAction(okAction)
                self.present(ac, animated: true, completion: nil)
                
                print("Error sending password recovery email: \(error?.localizedDescription)")
                return
            }
            let acSuccess = UIAlertController(title: "Head to your inbox", message: "A password reset link has been sent to the email provided.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            acSuccess.addAction(okAction)
            self.present(acSuccess, animated: true, completion: nil)
        }
    }
    @objc func handleTextInputChange() {
        guard let email = passwordRecoveryTextField.text?.lowercased() else { return }
        let isFormValid = email.count > 0 && email.hasSuffix("@gmail.com")
        
        if isFormValid {
            passwordRecoveryButton.isEnabled = true
            passwordRecoveryButton.backgroundColor = UIColor.buttonGreen()
        }
        else {
            passwordRecoveryButton.isEnabled = false
            passwordRecoveryButton.backgroundColor = UIColor.barGray()
        }
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    private func setupConstraints() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 3).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -35).isActive = true
        
        passwordRecoveryTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordRecoveryTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        passwordRecoveryTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -8).isActive = true
        passwordRecoveryTextField.bottomAnchor.constraint(equalTo: inputsContainerView.bottomAnchor).isActive = true
        
        passwordRecoveryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordRecoveryButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        passwordRecoveryButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordRecoveryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5.0).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 65.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
}
