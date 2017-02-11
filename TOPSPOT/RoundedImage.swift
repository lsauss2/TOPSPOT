//
//  RoundedImage.swift
//  TOPSPOT
//
//  Created by Ludo on 11/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = 5
        
    }
    
}
