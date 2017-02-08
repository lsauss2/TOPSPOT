//
//  SignUpVC.swift
//  TOPSPOT
//
//  Created by Ludo on 08/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet var usernameField: CustomTextField!
    
    @IBOutlet var emailField: CustomTextField!
    @IBOutlet var passwordField: CustomTextField!

    @IBOutlet var confirmPasswordField: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        if let username = usernameField.text, let email = emailField.text, let password = passwordField.text, let passwordConfirmation = confirmPasswordField.text {
            
            if passwordConfirmation == password {
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    
                    if error != nil {
                        print("LUDO: There as been a problem creating a user: \(error.debugDescription)")
                    } else {
                        print("LUDO: Successfully creating a user")
                        let userData = ["provider": user!.providerID]
                        self.completeSignIn(id: user!.uid, userData: userData )
                        
                    }
                    
                })
                
            }
            
            
        }
        
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        print("User added to the Database")
        performSegue(withIdentifier: "signUpUser", sender: self)
    }


}
