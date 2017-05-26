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

