//
//  LoginViewController.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/19/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

enum LoginType: String {
    case signUp = "Sign Up"
    case signIn = "Sign In"
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    let appBanner: UIImage = UIImage(named: "WaterCanIOBanner.png")!
    lazy var appBannerView: UIImageView = UIImageView(image: appBanner)
    
    let defaults = UserDefaults.standard
    let plantController = PlantController.shared
    
    var loginType = LoginType.signUp
    
    var usernameTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var phoneNumberTextField: UITextField = UITextField()
    
    var loginTypeSegmentedControl: UISegmentedControl = {
        let items = [LoginType.signUp.rawValue, LoginType.signIn.rawValue]
        let segmentedControl = UISegmentedControl(items: items)
        return segmentedControl
        }()
    
    var signInButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if plantController.bearer != nil {
            let destinationVC = PlantTableViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        view.backgroundColor = .white
        setUpViews()
    }
    
    // MARK: - Methods
    
    func setUpViews() {
        view.addSubview(appBannerView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(loginTypeSegmentedControl)
        view.addSubview(signInButton)
        
        appBannerView.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appBannerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            appBannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginTypeSegmentedControl.topAnchor.constraint(equalTo: appBannerView.bottomAnchor, constant: 24),
            loginTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 24),
            
            usernameTextField.topAnchor.constraint(equalTo: loginTypeSegmentedControl.bottomAnchor, constant: 24),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: 196),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 24),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 196),
            
            passwordTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 24),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 196),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 96),
        ])
        
        loginTypeSegmentedControl.selectedSegmentIndex = 0
        loginTypeSegmentedControl.addTarget(self, action: #selector(signInTypeChanged), for: .valueChanged)
        
        usernameTextField.placeholder = "Username"
        usernameTextField.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        usernameTextField.font = UIFont.systemFont(ofSize: 15)
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        usernameTextField.autocorrectionType = UITextAutocorrectionType.no
        usernameTextField.keyboardType = UIKeyboardType.default
        usernameTextField.returnKeyType = UIReturnKeyType.done
        usernameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        usernameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        phoneNumberTextField.font = UIFont.systemFont(ofSize: 15)
        phoneNumberTextField.borderStyle = UITextField.BorderStyle.roundedRect
        phoneNumberTextField.autocorrectionType = UITextAutocorrectionType.no
        phoneNumberTextField.keyboardType = UIKeyboardType.default
        phoneNumberTextField.returnKeyType = UIReturnKeyType.done
        phoneNumberTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        phoneNumberTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.frame = CGRect(x: 0, y: 0, width: 250, height: 40)
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        signInButton.backgroundColor = .none
        signInButton.setTitle("Sign Up", for: .normal)
        signInButton.layer.borderWidth = 2.0
        signInButton.layer.borderColor = ColorsHelper.lightGreen.cgColor
        signInButton.setTitleColor(ColorsHelper.lightGreen, for: .normal)
        signInButton.layer.cornerRadius = 6.0
        signInButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: - OBJC Functions
    
    @objc func buttonTapped() {
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let phoneNumber = phoneNumberTextField.text
            {
            let user = User(username: username,
                            password: password,
                            phonenumber: phoneNumber)
            
            // Depending on LoginType:
            if loginType == .signUp {
                plantController.signUp(with: user, completion: { (result) in
                    self.phoneNumberTextField.isHidden = false
                    do {
                        let success = try result.get()
                        if success {
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Sign Up Complete",
                                                                        message: "Please sign in",
                                                                        preferredStyle: .alert)
                                let alertAction = UIAlertAction(title: "OK",
                                                                style: .default,
                                                                handler: nil)
                                alertController.addAction(alertAction)
                                self.present(alertController, animated: true) {
                                    self.loginType = .signIn
                                    self.loginTypeSegmentedControl.selectedSegmentIndex = 1
                                    self.signInButton.setTitle("Sign In", for: .normal)
                                    self.phoneNumberTextField.isHidden = true
                                }
                                UIView.animate(withDuration: 0.5) {
                                    self.phoneNumberTextField.removeFromSuperview()
                                    self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 24).isActive = true
                                    self.view.layoutIfNeeded()
                                }
                            }
                        }
                    } catch {
                        NSLog("Error signing up: \(error)")
                    }
                })
            } else {
                plantController.signIn(with: user, completion: { (result) in
                    do {
                        let success = try result.get()
                        if success {
                            DispatchQueue.main.async {
                                let destinationVC = PlantTableViewController()
                                // Adds to the nav stack
                                self.navigationController?.setViewControllers([destinationVC], animated: true)
                                self.navigationController?.present(destinationVC, animated: true, completion: nil)
                                print("Sign In Successful!")
                            }
                        }
                    } catch {
                        if let error = error as? PlantController.NetworkError {
                            switch error {
                            case .failedSignIn:
                                NSLog("Sign in failed")
                            case .noToken:
                                NSLog("Invalid or missing token")
                            case .noData:
                                NSLog("No data received")
                            default:
                                NSLog("Unknown error occured")
                            }
                        }
                    }
                })
            }
        }
    }
    
    @objc func signInTypeChanged() {
        if loginTypeSegmentedControl.selectedSegmentIndex == 0 {
            loginType = .signUp
            signInButton.setTitle("Sign Up", for: .normal)
            UIView.animate(withDuration: 0.35) {
                self.passwordTextField.removeFromSuperview()
                self.setUpViews()
                self.view.layoutIfNeeded()
            }
        } else {
            loginType = .signIn
            signInButton.setTitle("Sign In", for: .normal)
            UIView.animate(withDuration: 0.35) {
                self.phoneNumberTextField.removeFromSuperview()
                self.passwordTextField.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 24).isActive = true
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

