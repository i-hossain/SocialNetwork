//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Ismail Hossain on 2017-05-16.
//  Copyright © 2017 Ismail Hossain. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                self.authenticateWithFirebase(credential)
            }
        }
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("Successfully logged in with email")
                }
                else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Could not create user \(error.debugDescription)")
                        }
                        else {
                            print("Successfully created user account")
                        }
                    })
                }
            })
        }
    }
    
    
    func authenticateWithFirebase(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Error: \(error.debugDescription)")
            }
            else {
                print("Successfully authenticated with Firebase")
            }
        }
    }
    
    
}

