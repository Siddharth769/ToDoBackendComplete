//
//  SignUpViewController.swift
//  ToDoBackend
//
//  Created by siddharth on 14/02/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var viewBelowEmail: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var viewBelowPassword: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setRoundedFields()
        addImageToTextField()
    }

    @IBAction func signUpButton(_ sender: Any) {
        SignUpUser()
    }

}

extension SignUpViewController {
    
    func SignUpUser(){
        let email = emailField.text
        let password = passwordField.text
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.showAlert("Enter a valid email.")
                    case .emailAlreadyInUse:
                        self.showAlert("Email already in use.")
                    default:
                        self.showAlert("Error: \(error.localizedDescription)")
                    }
                }
                return
            }
            self.signIn()
        })
    }
    
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "To Do App", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func signIn() {
        performSegue(withIdentifier: "signInFromSignUpSegue", sender: nil)
    }
    
}

extension SignUpViewController {
    
    func setRoundedFields(){
        emailField.clipsToBounds = true
        emailField.layer.cornerRadius = 15
        passwordField.clipsToBounds = true
        passwordField.layer.cornerRadius = 15
        viewBelowEmail.clipsToBounds = true
        viewBelowEmail.layer.cornerRadius = 15
        viewBelowPassword.clipsToBounds = true
        viewBelowPassword.layer.cornerRadius = 15
        signUpButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 15
        
        viewBelowEmail.backgroundColor = UIColor.white.withAlphaComponent(0.45)
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
        emailField.leftViewMode = UITextField.ViewMode.always
        emailField.leftView = imageView
        emailField.addSubview(imageView)
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

