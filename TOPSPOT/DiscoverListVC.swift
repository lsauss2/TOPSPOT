//
//  DiscoverListVC.swift
//  TOPSPOT
//
//  Created by Ludo on 08/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import Alamofire

class DiscoverListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableCell: UITableView!
    
    
    let transitionManager = TransitionManager()
    var places = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableCell.delegate = self
        tableCell.dataSource = self
        
        downloadPlaces {
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPlace = places[indexPath.row]
        performSegue(withIdentifier: "showPlace", sender: selectedPlace)
        
    }
    
    func downloadPlaces(completed: @escaping DownloadComplete) {
        
        let forecastUrl = URL(string: test_url)
        Alamofire.request(forecastUrl!).responseJSON {response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let placesResult = dict["results"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in placesResult {
                        
                        var name = ""
                        var address = ""
                        var mainPhotoReference = ""
                        var placeId = ""
                        var rating:Double = 0.0
                        var lat:Float = 0.0
                        var lon:Float = 0.0
                        
                        if let placeName = obj["name"] as? String {
                            name = placeName
                        }
                        
                        if let placeAddress = obj["vicinity"] as? String {
                            address = placeAddress
                        }
                        
                        if let photoReference = obj["photos"] as? [Dictionary<String, AnyObject>] {
                            
                            if let finalPhotoRef = photoReference[0]["photo_reference"] as? String {
                                
                                mainPhotoReference = finalPhotoRef
                                
                            }
                            
                        }
                        
                        if let finalPlaceId = obj["place_id"] as? String {
                            placeId = finalPlaceId
                        }
                        
                        if let placeRating = obj["rating"] as? Double {
                            rating = placeRating
                        }
                        
                        if let placeGeometry = obj["geometry"] as? Dictionary<String, AnyObject> {
                            
                            if let placeLocation = placeGeometry["location"] as? Dictionary<String, Float> {
                                
                                if let placeLatitude = placeLocation["lat"] {
                                    lat = placeLatitude
                                }
                                
                                if let placeLongitude = placeLocation["lng"] {
                                    lon = placeLongitude
                                }
                                
                            }
                            
                        }
                        
                        
                        
                        let place = Place(name: name, address: address, reference: mainPhotoReference, place_id: placeId, rating: rating, lat: lat, long: lon)
                        
                        
                        self.places.append(place)
                        
                    }
                    
                    self.tableCell.reloadData()
                    
                }
                
            }
            
            completed()
        }
        
    }
    
    @IBAction func logOutUser(_ sender: Any) {
        let keychainresult = KeychainWrapper.standard.remove(key: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination as UIViewController
        toViewController.transitioningDelegate = self.transitionManager
        
        if segue.identifier == "showPlace" {
            
            if let detailsVC = segue.destination as? PlaceViewVC {
                
                if let place = sender as? Place {
                    
                    detailsVC.place = place
                    
                }
                
            }
            
        }
    }

}
