//
//  searchCell.swift
//  TOPSPOT
//
//  Created by Ludo on 13/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class searchCell: UITableViewCell {
    
    @IBOutlet var placeName: UILabel!
    @IBOutlet var placeAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(place: PlaceLight) {
        placeName.text = place.placeName
        placeAddress.text = place.placeAddress
    }
}
