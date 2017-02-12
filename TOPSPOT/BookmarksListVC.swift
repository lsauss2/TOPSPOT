//
//  BookmarksListVC.swift
//  TOPSPOT
//
//  Created by Ludo on 12/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase

class BookmarksListVC: UIViewController {
    
    @IBOutlet var emptyStateImage: UIImageView!
    
    @IBOutlet var emptyStateLabel: UILabel!
    @IBOutlet var emptyStateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startDiscoveringTapped(_ sender: Any) {
        
        self.tabBarController?.selectedIndex =  0
        
    }
    
    

}
