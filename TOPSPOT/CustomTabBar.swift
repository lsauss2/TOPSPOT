//
//  CustomTabBar.swift
//  TOPSPOT
//
//  Created by Ludo on 12/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.barTintColor = UIColor.white
        self.shadowImage = UIImage()
    }

}
