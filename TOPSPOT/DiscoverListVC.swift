//
//  DiscoverListVC.swift
//  TOPSPOT
//
//  Created by Ludo on 08/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase

class DiscoverListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutUser(_ sender: Any) {
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: true, completion: nil)
    }
    

}
