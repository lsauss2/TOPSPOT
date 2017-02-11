//
//  PlaceViewVC.swift
//  TOPSPOT
//
//  Created by Ludo on 11/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class PlaceViewVC: UIViewController {
    
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var heartButton: UIImageView!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var placeName: UILabel!
    @IBOutlet var placeAddress: UILabel!
    @IBOutlet var placeDescription: UILabel!
    @IBOutlet var mapImage: UIImageView!
    @IBOutlet var placeRating: UILabel!
    @IBOutlet var placeReviewNumber: UILabel!
    
    var place: Place!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTitle.text = place.placeName
        placeName.text = place.placeName
        placeAddress.text = place.placeAddress
        placeRating.text = "\(place.placeRating)"
        
        let placePhotoReference = place.placePhotoReference
        let photoUrl = "\(base_photos_url)key=\(api_key)&photoreference=\(placePhotoReference)&maxwidth=400"
        
        if let url = NSURL(string: photoUrl) {
            if let data = NSData(contentsOf: url as URL) {
                mainImage.image = UIImage(data: data as Data)
            }
        }
        
        let roundedRating = Int(round(place.placeRating))
        let difrounded = 5 - roundedRating

        var offset = 0
        for index in 1...roundedRating {
            
            var xposition = 30 + offset
            let filledStar = UIImageView(frame: CGRect(x: xposition, y: 371, width: 15, height: 15))
            filledStar.image = UIImage(named: "star-filled-icon")
            self.view.addSubview(filledStar)
            offset += 19
            
        }
        
        if difrounded != 0 {
        
            for index in 1...difrounded {
            var newxposition = 30 + offset
            let unfilledStar = UIImageView(frame: CGRect(x: newxposition, y: 371, width: 15, height: 15))
            unfilledStar.image = UIImage(named: "star-empty-icon")
            self.view.addSubview(unfilledStar)
            offset += 19
            }
            
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
