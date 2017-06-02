//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Ismail Hossain on 2017-06-02.
//  Copyright © 2017 Ismail Hossain. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutBtnPressed(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: "uid")
        try! Auth.auth().signOut()
        dismiss(animated: true) { 
            print("Removed Login details from Keychain")
        }
    }
}
