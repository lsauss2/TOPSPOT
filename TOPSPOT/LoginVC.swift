//
//  ViewController.swift
//  TOPSPOT
//
//  Created by Ludo on 08/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet var emailAddressField: CustomTextField!
    
    @IBOutlet var passwordField: CustomTextField!
    
    @IBOutlet var forgotPasswordButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInTapped(_ sender: Any) {
        
        if let email = emailAddressField.text, let password = passwordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil {
                    print("There was an error")
                } else {
                    print("User logged completed")
                    let userData = ["provider": user!.providerID]
                    self.completeSignIn(id: user!.uid, userData: userData )
                }
                
            })
            
            
        }
        
    }
    
    @IBAction func facebookConnectTapped(_ sender: Any) {
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        print("User added to the Database")
        performSegue(withIdentifier: "loginUser", sender: self)
    }


}

