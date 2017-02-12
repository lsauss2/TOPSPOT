//
//  User.swift
//  TOPSPOT
//
//  Created by Ludo on 12/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    private var _userId:String!
    private var _userName:String!
    private var _userEmailAddress:String!
    private var _userLocation:String!
    private var _userDescription:String!
    private var _userImage:String!
    
    var userId:String {
        return _userId
    }
    
    var userName:String {
        return _userName
    }
    
    var userEmailAddres:String {
        return _userEmailAddress
    }
    
    var userLocation:String {
        return _userLocation
    }
    
    var userDescription:String {
        if _userDescription == nil {
            _userDescription = ""
        }
        return _userDescription
    }
    
    var userImage:String {
        if _userImage == nil {
            _userImage = ""
        }
        return _userImage
    }
    
    init(id:String, email:String) {
        _userId = id
        _userEmailAddress = email
    }
    
    func getUserDetails(completed: @escaping DownloadComplete){
        DataService.ds.REF_USERS.child(_userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let name = value?["username"] as? String {
                self._userName = name
            }
            
            if let location = value?["location"] as? String {
                self._userLocation = location
            }
            
            if let description = value?["description"] as? String {
                self._userDescription = description
            }
            
            completed()
        })
    }
    
}
