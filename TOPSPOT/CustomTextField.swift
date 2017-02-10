//
//  CustomTextField.swift
//  TOPSPOT
//
//  Created by Ludo on 08/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    let border = CALayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        border.frame = CGRect(x: 0, y: self.frame.size.height - 0.5, width: self.frame.size.width, height: 0.5)
        border.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0).cgColor
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
}
