//
//  SignInViewController.swift
//  WaterMyPlantsBW
//
//  Created by BrysonSaclausa on 8/21/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

//MARK: - (View Controller) SignInViewController.swift

class SignInViewController: UIViewController {
    
    enum LoginType {
        case signUp
        case signIn
    }
    
    var plantController: PlantController?
    var loginType = LoginType.signUp


        //MARK: - IB OUTLETS

    @IBOutlet weak var signInSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 8
    }

 
 
        //MARK: - IB ACTIONS

    @IBAction func signInTypeSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            signInButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .signIn
            signInButton.setTitle("Sign In", for: .normal)
        }
    }
    
//    @IBAction func signInButton(_ sender: UIButton) {
//               if let username = usernameTextField.text,
//                !username.isEmpty,
//                let password = passwordTextField.text,
//                !password.isEmpty,
//                let phoneNumber = phoneNumberTextField.text,
//                !phoneNumber.isEmpty
//                {
//                let user = User(id: <#T##Int#>, username: <#T##String#>, password: <#T##String#>, phoneNumber: <#T##String#>)
//                switch loginType {
//                case .signUp:
//                    plantController?.signUp(with: user, completion: { (result) in
//                        do {
//                            let success = try result.get()
//                            if success {
//                                DispatchQueue.main.async {
//                                    let alertController = UIAlertController(title: "Sign up successful!", message: "Please log in.", preferredStyle: .alert)
//                                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                                    alertController.addAction(alertAction)
//                                    self.present(alertController, animated: true) {
//                                        self.loginType = .signIn
//                                        self.signInSegmentedControl.selectedSegmentIndex = 1
//                                        self.signInButton.setTitle("Sign In", for: .normal)
//                                    }
//                                }
//                            }
//                        } catch {
//                            print("Error signing up: \(error)")
//                        }
//                    })
//                case .signIn:
//                    plantController?.signIn(with: user, completion: { (result) in
//                        do {
//                            let success = try result.get()
//                            if success {
//                                DispatchQueue.main.async {
//                                    self.dismiss(animated: true, completion: nil)
//
//                                }
//                            }
//                        } catch {
//                            if let error = error as? PlantController.NetworkError {
//                                switch error {
//                                case .failedSignIn:
//                                    print("Sign in failed")
//                                case .noData, .noToken:
//                                    print("No data received")
//                                default:
//                                    print("Other error occurred")
//                                }
//                            }
//                        }
//                    })
//                }
//            }
        }
    

