//
//  PlacePreviewVC.swift
//  TOPSPOT
//
//  Created by Ludo on 13/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class PlacePreviewVC: UIViewController {
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var mainAddress: UILabel!
    
    var place: PlaceLight!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = FIRAuth.auth()?.currentUser
        let uid = currentUser?.uid
        let email = currentUser?.email
        user = User(id: uid!, email: email!)
        
        place.downloadPlaceDetails {
            self.updateUI()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        mainTitle.text = place.placeName
        mainAddress.text = place.placeAddress
        
        let placePhotoReference = place.placePhotoReference
        let photoUrl = "\(base_photos_url)key=\(api_key)&photoreference=\(placePhotoReference)&maxwidth=400"
        
        if let url = NSURL(string: photoUrl) {
            if let data = NSData(contentsOf: url as URL) {
                mainImage.image = UIImage(data: data as Data)
            }
        }
        
        
    }
    
    @IBAction func savePlace(_ sender: Any) {
        
        let placeDict:Dictionary<String, Any> = ["id": place.placeId, "name": place.placeName, "rating": 0, "address": place.placeAddress, "photo_reference": place.placePhotoReference]
        
        DataService.ds.createPlaceDBReference(id: place.placeId, placeData: placeDict)
        
        DataService.ds.REF_USERS.child(user.userId).child("likes").observeSingleEvent(of: .value, with: { (snapshot) in
                
                self.user.likePlace(userId: self.user.userId, placeId: self.place.placeId, type: "add")
            
            
        })
        
    }
    

}
