//
//  CircledView.swift
//  TOPSPOT
//
//  Created by Ludo on 11/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class CircledView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        
        self.clipsToBounds = true
        layer.cornerRadius = self.frame.size.height / 2
        
    }

}
