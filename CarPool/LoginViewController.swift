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
                    NotificationCenter.default.post(name: logMeinNotification, object: nil)
                })
            }
        } else if segmentedControlLoginSignup.selectedSegmentIndex == 1 {
            if passwordTextField.text! == confirmPasswordTextField.text {
                API.signUp(email: emailTextField.text!, password: passwordTextField.text!, fullName: fullNameTextField.text!, completion: { (result) in 
                    NotificationCenter.default.post(name: logMeinNotification, object: nil)
                })
            }
        }
    }
}
