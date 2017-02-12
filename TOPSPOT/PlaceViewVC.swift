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
    
    @IBOutlet var mainTitle: ExoLabel!
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
        
        place.downloadPlaceDetails {
            self.updateUI()
            self.setRating()
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setRating(){
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
    
    func updateUI(){
        
        let count = place.placeName.characters.count
        let attributedString = NSMutableAttributedString(string: place.placeName.uppercased())
        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(1), range: NSRange(location: 0, length: count))
        
        mainTitle.attributedText = attributedString
        placeName.text = place.placeName
        placeAddress.text = place.placeAddress
        placeRating.text = "\(place.placeRating)"
        placeReviewNumber.text = "\(place.placeReviews.count) Reviews"
        let mainReview = place.placeReviews[0]["text"]
        placeDescription.text = mainReview as! String
        
        let placePhotoReference = place.placePhotoReference
        let photoUrl = "\(base_photos_url)key=\(api_key)&photoreference=\(placePhotoReference)&maxwidth=400"
        
        if let url = NSURL(string: photoUrl) {
            if let data = NSData(contentsOf: url as URL) {
                mainImage.image = UIImage(data: data as Data)
            }
        }
        
        let secondPhotoReference = place.placeOtherPhotos[0]
        let secondPhotoUrl = "\(base_photos_url)key=\(api_key)&photoreference=\(secondPhotoReference)&maxwidth=400"
        
        if let url = NSURL(string: secondPhotoUrl) {
            if let data = NSData(contentsOf: url as URL) {
                let secondImage = RoundedImage(frame: CGRect(x: 230, y: 128, width: 180, height: 140))
                secondImage.image = UIImage(data: data as Data)
                self.view.addSubview(secondImage)
            }
        }
        
        if let url = NSURL(string: "https://api.mapbox.com/styles/v1/ludosauss/cil9vk1jm006xcym1pj5wqtse/static/2.177464,41.380553,15.48,0.00,0.00/600x400?access_token=pk.eyJ1IjoibHVkb3NhdXNzIiwiYSI6InZyaUhwaE0ifQ.fDxrhN-KS4tmZrzSYDbL_g") {
            
            if let data = NSData(contentsOf: url as URL) {
                mapImage.image = UIImage(data: data as Data)
            }
            
        }
        
        
    }

}
