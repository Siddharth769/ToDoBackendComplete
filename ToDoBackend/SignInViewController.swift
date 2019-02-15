//
//  SignInViewController.swift
//  ToDoBackend
//
//  Created by siddharth on 14/02/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var viewBelowUsername: UIView!
    @IBOutlet weak var viewBelowPassword: UIView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoundedFields()
        addImageToTextField()
    }
    
    @IBAction func signInButton(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        setupForgotPasswordPrompt()
    }

}

extension SignInViewController {
    
    func loginUser(){
        let email = usernameField.text
        let password = passwordField.text
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
            guard let _ = user else {
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            self.showAlert("User account not found. Try registering")
                        case .wrongPassword:
                            self.showAlert("Incorrect username/password combination")
                        default:
                            self.showAlert("Error: \(error.localizedDescription)")
                        }
                    }
                }
                assertionFailure("user and error are nil")
                return
            }
            self.signIn()
        })
    }
    
    func setupForgotPasswordPrompt() {
        let prompt = UIAlertController(title: "ToDo App", message: "Email:", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "Okay", style: .default) { (action) in
            let userInputs = prompt.textFields![0].text
            if (userInputs!.isEmpty) {
                return
            }
            Auth.auth().sendPasswordReset(withEmail: userInputs!, completion: {(error) in
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            DispatchQueue.main.async {
                                self.showAlert("User account not found. Try registering")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.showAlert("You'll receive an email shortly to reset your password.")
                    }
                }
                
            })
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okaction)
        present(prompt, animated: true, completion: nil)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "To Do App", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func signIn() {
        performSegue(withIdentifier: "signInFromSignInSegue", sender: nil)
    }

}

extension SignInViewController {
    
    func setRoundedFields(){
        usernameField.clipsToBounds = true
        usernameField.layer.cornerRadius = 15
        passwordField.clipsToBounds = true
        passwordField.layer.cornerRadius = 15
        viewBelowUsername.clipsToBounds = true
        viewBelowUsername.layer.cornerRadius = 15
        viewBelowPassword.clipsToBounds = true
        viewBelowPassword.layer.cornerRadius = 15
        signInButton.clipsToBounds = true
        signInButton.layer.cornerRadius = 15
        
        viewBelowUsername.backgroundColor = UIColor.white.withAlphaComponent(0.45)
        viewBelowPassword.backgroundColor = UIColor.white.withAlphaComponent(0.45)
    }
    
    func addImageToTextField(){
        addImageToPasswordField()
        addImageToUsernameField()
    }
    
    func addImageToUsernameField(){
        let imageView = UIImageView()
        let image = UIImage(named: "email")
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 17)
        imageView.contentMode = .scaleAspectFit
        usernameField.leftViewMode = UITextField.ViewMode.always
        usernameField.leftView = imageView
        usernameField.addSubview(imageView)
    }
    
    func addImageToPasswordField(){
        let imageView = UIImageView()
        let image = UIImage(named: "password")
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 17)
        imageView.contentMode = .scaleAspectFit
        passwordField.leftViewMode = UITextField.ViewMode.always
        passwordField.leftView = imageView
        passwordField.addSubview(imageView)
    }
    
    
}
