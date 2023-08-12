//
//  LoginViewController.swift
//  Siloam Test
//
//  Created by Apple on 11/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        print("Sign in tapped")
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
    }
}
