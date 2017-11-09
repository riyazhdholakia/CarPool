//
//  LoginViewController.swift
//  CarPool
//
//  Created by Naina  on 11/9/17.
//  Copyright © 2017 Riyazh. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    
    @IBOutlet weak var segmentedControlLoginSignup: UISegmentedControl!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    @IBOutlet weak var loginSignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func onSegmentedControlLoginSignupPressed(_ sender: UISegmentedControl) {
        switch segmentedControlLoginSignup.selectedSegmentIndex{
            
        case 0:
            confirmPassword.isHidden = true
            loginSignupButton.setTitle("Login", for: .normal)
        case 1:
            confirmPassword.isHidden = false
            loginSignupButton.setTitle("Signup", for: .normal)
        default:
            break
        }
    }
    @IBAction func loginSignupPressed(_ sender: UIButton) {
        if emailTextField.text != nil, passwordTextField.text != nil {
            if segmentedControlLoginSignup.selectedSegmentIndex == 0 {
//                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                    if let error = confirmPassword {
                        //TODO alert
                    } else {
                        NotificationCenter.default.post(name: logMeinNotification, object: nil)
                    }
                }
            } else if segmentedControlLoginSignup.selectedSegmentIndex == 1 {
//                if passwordTextField.text! == confirmPasswordTextField.text {
//                    Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
                        if let error = passwordTextField {
                            //TODO alert
                        } else {
                            NotificationCenter.default.post(name: logMeinNotification, object: nil)
                        }
                    }
                }
            }







