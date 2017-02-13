//
//  PlaceLight.swift
//  TOPSPOT
//
//  Created by Ludo on 13/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import Foundation
import Alamofire

class PlaceLight {
    
    private var _placeId:String!
    private var _placeName:String!
    private var _placeAddress:String!
    private var _placePhotoReference:String!
    private var _placeDetailsUrl:String!
    
    var placeId:String{
        if _placeId == nil {
            _placeId = ""
        }
        return _placeId
    }
    
    var placeName:String {
        if _placeName == nil {
            _placeName = ""
        }
        return _placeName
    }
    
    var placeAddress:String {
        if _placeAddress == nil {
            _placeAddress = ""
        }
        return _placeAddress
    }
    
    var placePhotoReference:String {
        if _placePhotoReference == nil {
            _placePhotoReference = ""
        }
        return _placePhotoReference
    }
    
    var placeDetailsUrl:String {
        if _placeDetailsUrl == nil {
            _placeDetailsUrl = ""
        }
        return _placeDetailsUrl
    }
    
    init(id:String, name:String, address:String){
        _placeId = id
        _placeName = name
        _placeAddress = address
        
        let placeDetailsUrl = "\(base_details_url)key=\(api_key)&placeid=\(id)"
        self._placeDetailsUrl = placeDetailsUrl
    }
    
    func downloadPlaceDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(placeDetailsUrl).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let result = dict["result"] as? Dictionary<String, AnyObject> {
                    
                    if let photoReference = result["photos"] as? [Dictionary<String, AnyObject>] {
                        
                        if let finalPhotoRef = photoReference[0]["photo_reference"] as? String {
                            
                            self._placePhotoReference = finalPhotoRef
                            
                        }
                        
                    }
                    
                }
                
            }
            
            completed()
        }
        
    }
    
    
    
}
