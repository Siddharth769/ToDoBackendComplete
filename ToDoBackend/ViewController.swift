//
//  ViewController.swift
//  ToDoBackend
//
//  Created by siddharth on 14/02/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var signInContainerView: UIView!
    @IBOutlet weak var signUpContainerView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInBar: UIView!
    @IBOutlet weak var signUpBar: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        autoSignIn()
    }
    
    func autoSignIn(){
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.signIn()
            }
        }
    }
    
    func signIn() {
        performSegue(withIdentifier: "signInDirectlyIfUserDidntLogOutSegue", sender: nil)
    }


    @IBAction func signInButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.signInContainerView.alpha = 1
            self.signUpContainerView.alpha = 0
            self.signUpContainerView.isUserInteractionEnabled = false
            self.signInContainerView.isUserInteractionEnabled = true
            self.signInButton.alpha = 1
            self.signUpButton.alpha = 0.3
            self.signInBar.alpha = 1
            self.signUpBar.alpha = 0
        })
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.signInContainerView.alpha = 0
            self.signUpContainerView.alpha = 1
            self.signInContainerView.isUserInteractionEnabled = false
            self.signUpContainerView.isUserInteractionEnabled = true
            self.signUpButton.alpha = 1
            self.signInButton.alpha = 0.3
            self.signInBar.alpha = 0
            self.signUpBar.alpha = 1
        })
        
        
    }
}

