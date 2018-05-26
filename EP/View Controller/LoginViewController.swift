//  LoginController.swift
import UIKit
import Firebase


class LoginViewController: UIViewController {
    //MARK: - Properties
    //****************************** VIEWS ********************************
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a valid @navy.mil or @usmc.mil email address."
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.backgroundColor = UIColor.barGray()
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginOrRegister), for: .touchUpInside)
        return button
    }()
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ap256")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.offWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.text = UserDefaults.standard.string(forKey: "email") ?? ""
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = .none
        tf.clearButtonMode = .whileEditing
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.clearButtonMode = .whileEditing
         tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.backgroundColor = UIColor.mainColorScheme1()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.layer.cornerRadius = 3
        sc.layer.masksToBounds = true
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterSegmentedControlChange), for: .valueChanged)
        return sc
    }()
    let passwordResetLabel: UIButton = {
        let view = UIButton()
        view.isUserInteractionEnabled = true
        view.setTitle("Reset password", for: .normal)
        view.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.offWhite(), for: .normal)
        view.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return view
    }()
    //**********************************************************************
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login controller viewDidLoad")
        view.backgroundColor = UIColor.mainColorScheme1()
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(logoImageView)
        view.addSubview(passwordResetLabel)
        setupLoginRegisterSegmentedControl()
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupLogoImageView()
        setupForgotPasswordButton()
    }
    //MARK: - Local Functions
    @objc func handleForgotPassword() {
        
    }
    @objc func handleLoginOrRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }
        else {
            handleRegister()
        }
    }
    @objc private func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { print("Form is not valid"); return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            //have to do if let error = (error as NSError?).userInfo[error_name]
            if error != nil {
                let ac = UIAlertController(title: "Sorry!", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                ac.addAction(okAction)
                self.present(ac, animated: true, completion: {
                    print("Error alert presented to user")
                })
                print("Error logging in: \(String(describing: error?.localizedDescription))")
                return
            }
            UserDefaults.standard.set(email, forKey: "email")
            print("logged in")
            
            //self.navigationController?.pushViewController(AircraftListViewController(), animated: true)
            
            //if the logged in user is verified
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { print("Form is not valid"); return }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                let ac = UIAlertController(title: "Sorry!", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                ac.addAction(okAction)
                self.present(ac, animated: true, completion: nil)
                print("Error in handling registration: \(String(describing: error?.localizedDescription))")
            }
            guard let uid = user?.uid else { return }
            let ref = Database.database().reference(fromURL: "https://emergencyprocedure-42955.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let date = dateFormatter.string(from: Date())
            let values = ["email": email, "account_created_date": date]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print("Error saving user: \(String(describing: error?.localizedDescription))")
                    return
                }
                print("User successfully registered into db")
                //send email
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    print("Auth email error status: \(String(describing: error?.localizedDescription))")
                })
               
                //alert user
                let ac = UIAlertController(title: "Account verification required", message: "A verification e-mail has been sent to \(email)\n", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               ac.addAction(okAction)
                self.present(ac, animated: true, completion: {
                    print("alert presented to user")
                    self.loginRegisterSegmentedControl.selectedSegmentIndex = 0
                })
                //clear form
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                //self.dismiss(animated: true, completion: nil)
                //navigationController?.pushViewController(AircraftListViewController(), animated: true)
            })
        }
    }
    @objc func handleLoginRegisterSegmentedControlChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
    }
    @objc func handleTextInputChange() {
        guard let email = emailTextField.text?.lowercased() else { return }
        guard let password = passwordTextField.text else { return }
        let isFormValid = email.count > 0 && password.count > 4 && email.hasSuffix("@gmail.com")
        
        if isFormValid {
            loginRegisterButton.isEnabled = true
            loginRegisterButton.backgroundColor = UIColor.mainSchemeColor3()
        }
        else {
            loginRegisterButton.isEnabled = false
            loginRegisterButton.backgroundColor = UIColor.barGray()
        }
    }
    private func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        //emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -8).isActive = true

        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        //passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -8).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    private func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    private func setupLoginRegisterButton() {
    loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
    loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
    loginRegisterButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    private func setupLogoImageView() {
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -50).isActive = true

    }
    private func setupForgotPasswordButton() {
        passwordResetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordResetLabel.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 15).isActive = true
        passwordResetLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        passwordResetLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
