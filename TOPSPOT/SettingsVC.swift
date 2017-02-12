//
//  SettingsVC.swift
//  TOPSPOT
//
//  Created by Ludo on 12/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {
    
    
    @IBOutlet var userImageHolder: RoundedImage!
    @IBOutlet var userImageButton: UIButton!
    @IBOutlet var userNameField: CustomTextField!
    @IBOutlet var userEmailAddressField: CustomTextField!
    @IBOutlet var userLocationField: CustomTextField!
    
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
    
    func updateUI(){
        userNameField.text = user.userName
        userEmailAddressField.text = user.userEmailAddres
        userLocationField.text = user.userLocation
    }

}
