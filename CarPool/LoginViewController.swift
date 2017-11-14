//
//  LoginViewController.swift
//  CarPool
//
//  Created by Naina  on 11/9/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
import CarpoolKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var segmentedControlLoginSignup: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var loginSignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmPasswordTextField.isHidden = true
        fullNameTextField.isHidden = true
        
        
        fullNameTextField.layer.cornerRadius = 15
        confirmPasswordTextField.layer.cornerRadius = 15
        loginSignupButton.layer.cornerRadius = 15
        passwordTextField.layer.cornerRadius = 15
        emailTextField.layer.cornerRadius = 15
        segmentedControlLoginSignup.layer.cornerRadius = 15
    }
    
    @IBAction func onSegmentedControlLoginSignupPressed(_ sender: UISegmentedControl) {
        switch segmentedControlLoginSignup.selectedSegmentIndex {
        case 0:
            confirmPasswordTextField.isHidden = true
            fullNameTextField.isHidden = true
            loginSignupButton.setTitle("Login", for: .normal)
        case 1:
            confirmPasswordTextField.isHidden = false
            fullNameTextField.isHidden = false
            loginSignupButton.setTitle("Signup", for: .normal)
        default:
            break
        }
    }
    
    @IBAction func loginSignupPressed(_ sender: UIButton) {
        if emailTextField.text != nil, passwordTextField.text != nil {
            if segmentedControlLoginSignup.selectedSegmentIndex == 0 {
                API.signIn(email: emailTextField.text!, password: passwordTextField.text!, completion: { (result) in
                    switch result {
                    case .success(_):
                        NotificationCenter.default.post(name: logMeinNotification, object: nil) 
                    case .failure(let error):
                        print(error)
                    }
                })
            }
            else if segmentedControlLoginSignup.selectedSegmentIndex == 1 {
                if passwordTextField.text! == confirmPasswordTextField.text {
                    if fullNameTextField != nil {
                        if emailTextField != nil {
                            API.signUp(email: emailTextField.text!, password: passwordTextField.text!, fullName: fullNameTextField.text!, completion: { (result) in
                                switch result {
                                case .success(_):
                                    NotificationCenter.default.post(name: logMeinNotification, object: nil)
                                case .failure(let error):
                                    print(error)
                                }
                            })
                        }
                    }
                }
            }
            let loginVC = self.presentedViewController as? LoginViewController
            loginVC?.dismiss(animated: true, completion: nil)
        }
    }
}
