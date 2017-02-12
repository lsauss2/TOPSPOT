//
//  BookmarksListVC.swift
//  TOPSPOT
//
//  Created by Ludo on 12/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase

class BookmarksListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var emptyStateImage: UIImageView!
    @IBOutlet var emptyStateLabel: UILabel!
    @IBOutlet var emptyStateButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    var placesLiked:[String] = []
    var places = [Place]()
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = FIRAuth.auth()?.currentUser
        let uid = currentUser?.uid
        let email = currentUser?.email
        user = User(id: uid!, email: email!)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        getUserPlacesLiked {
            self.getUserPlace {
                if self.places.count == 0 {
                    self.emptyStateImage.isHidden = false
                    self.emptyStateLabel.isHidden = false
                    self.emptyStateButton.isHidden = false
                    self.tableView.isHidden = true
                }
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as? placeCell {
            
            let place = places[indexPath.row]
            
            cell.configureCell(place: place)
            
            return cell
            
        } else {
            return placeCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startDiscoveringTapped(_ sender: Any) {
        
        self.tabBarController?.selectedIndex =  0
        
    }
    
    func getUserPlace(completed: @escaping DownloadComplete){
        
        places.removeAll()
        DataService.ds.REF_PLACES.observe(.value, with: { (snapshot) in
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let id = postDict["id"] as! String
                        if self.placesLiked.contains(id) {
                        let name = postDict["name"] as! String
                        let address = postDict["address"] as! String
                        let photo_reference = postDict["photo_reference"] as! String
                        let rating = postDict["rating"] as! Double
                        let place = Place(name: name, address: address, reference: photo_reference, place_id: id, rating: rating, lat: 0, long: 0)
                        self.places.append(place)
                        }
                    }
                    
                }
                
            }
            self.tableView.reloadData()
            completed()
        })
        
    }
    
    func getUserPlacesLiked(completed: @escaping DownloadComplete){
        
        placesLiked.removeAll()
        DataService.ds.REF_USERS.child(user.userId).child("likes").observe(.value, with: { (snapshot) in
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    
                    self.placesLiked.append(snap.key)
                    
                }
                
            }
            completed()
        })
        
    }
    
    

}
