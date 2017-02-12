//
//  ProfileVC.swift
//  TOPSPOT
//
//  Created by Ludo on 12/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    
    @IBOutlet var mainUsername: UILabel!
    @IBOutlet var userImage: RoundedImage!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userLocationLabel: UILabel!
    @IBOutlet var userDescriptionLabel: UILabel!
    
    var user:User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var currentUser = FIRAuth.auth()?.currentUser
        let uid = currentUser?.uid
        let email = currentUser?.email
        user = User(id: uid!, email: email!)
        user.getUserDetails{
            self.updateUI()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        mainUsername.text = user.userName
        userNameLabel.text = user.userName
        userLocationLabel.text = user.userLocation
        userDescriptionLabel.text = user.userDescription
    }

}
