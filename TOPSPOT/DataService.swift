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
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>){
        
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
}
