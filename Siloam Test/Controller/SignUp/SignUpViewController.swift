//
//  SignUpViewController.swift
//  Siloam Test
//
//  Created by Apple on 11/08/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Variables
    
    lazy var signUpViewModel: SignUpViewModel = {
        return SignUpViewModel()
    }()
    lazy var commonMethods: CommonMethods = {
        return CommonMethods()
    }()
    var textFieldBtn = UIButton()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // initialize closures
        self.initializeClosure()
        
        // setup eye icon and set to password field
        self.setupPasswordField()
    }
    
    // MARK: - Actions
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let window = sceneDelegate.window
            if let loginController = UIStoryboard(name: StoryboardName.main, bundle: nil).instantiateViewController(withIdentifier: ControllerName.loginController) as? UINavigationController {
                window?.rootViewController = loginController
                window?.makeKeyAndVisible()
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        self.signUpViewModel.checkSignUpButtonFunctionality(username: usernameField.text ?? "", password: passwordField.text ?? "")
    }
    
    @objc func eyeButtonTapped() {
        signUpViewModel.updatePasswordField(textField: self.passwordField, fieldBtn: self.textFieldBtn)
    }
    
    // MARK: - Initialize Closures
    
    func initializeClosure() {
        self.initializeAlertClosure()
    }
    
    func initializeAlertClosure() {
        self.signUpViewModel.showAlert = { [weak self] message in
            guard let self = self else { return }
            // show alert
            self.commonMethods.showCommonAlert(viewController: self, message: message)
        }
    }
    
     // MARK: - Update Text Field
    
    func setupPasswordField() {
        self.textFieldBtn.setImage(UIImage(systemName: CommonStrings.eyeSlashImageName), for: .normal)
        self.textFieldBtn.frame = CGRect(x: CGFloat(passwordField.frame.size.width - 40), y: CGFloat(5), width: CGFloat(40), height: CGFloat(30))
        self.textFieldBtn.tintColor = UIColor.black
        self.textFieldBtn.addTarget(self, action: #selector(self.eyeButtonTapped), for: .touchUpInside)
        
        // add eye icon to password field
        self.passwordField.rightView = textFieldBtn
        self.passwordField.rightViewMode = .always
    }
}
