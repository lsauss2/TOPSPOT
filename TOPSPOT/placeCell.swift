//
//  placeCell.swift
//  TOPSPOT
//
//  Created by Ludo on 11/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class placeCell: UITableViewCell {
    
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var placeName: UILabel!
    @IBOutlet var placeAddress: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeImage.layer.cornerRadius = 5.0
        placeImage.clipsToBounds = true
    }
    
    func configureCell(place: Place){
        placeName.text = place.placeName
        placeAddress.text = place.placeAddress
        
        let placePhotoReference = place.placePhotoReference
        let photoUrl = "\(base_photos_url)key=\(api_key)&photoreference=\(placePhotoReference)&maxwidth=400"
        
        if let url = NSURL(string: photoUrl) {
            if let data = NSData(contentsOf: url as URL) {
                placeImage.image = UIImage(data: data as Data)
            }        
        }
        
        let placeRating = place.placeRating
        let roundedRating = Int(round(placeRating))
        let difrounded = 5 - roundedRating
        
        var offset = 0
        if roundedRating > 0 {
        for index in 1...roundedRating {
            
            var xposition = 200 + offset
            let filledStar = UIImageView(frame: CGRect(x: xposition, y: 73, width: 14, height: 14))
            filledStar.image = UIImage(named: "star-filled-icon")
            self.addSubview(filledStar)
            offset += 18
            
        }
        
        if difrounded != 0 {
            
            for index in 1...difrounded {
                var newxposition = 200 + offset
                let unfilledStar = UIImageView(frame: CGRect(x: newxposition, y: 73, width: 14, height: 14))
                unfilledStar.image = UIImage(named: "star-empty-icon")
                self.addSubview(unfilledStar)
                offset += 18
            }
            
        }
        }
        
    }

}
