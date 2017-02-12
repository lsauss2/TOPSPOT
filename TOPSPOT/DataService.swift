//
//  DataService.swift
//  TOPSPOT
//
//  Created by Ludo on 08/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_PLACES = DB_BASE.child("places")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_PLACES: FIRDatabaseReference {
        return _REF_PLACES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>){
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
    func createPlaceDBReference(id: String, placeData: Dictionary<String, Any>){
        REF_PLACES.child(id).updateChildValues(placeData)
    }
    
}
