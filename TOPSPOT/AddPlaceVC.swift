//
//  AddPlaceVC.swift
//  TOPSPOT
//
//  Created by Ludo on 13/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class AddPlaceVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let transitionManager = TransitionManager()
    var places = [PlaceLight]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        downloadPlaces {
            
            
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? searchCell {
            
            let place = places[indexPath.row]
            
            cell.configureCell(place: place)
            
            return cell
            
        } else {
            return searchCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = places[indexPath.row]
        performSegue(withIdentifier: "showPlaceAdd", sender: selectedPlace)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText != "" {
        let newSearchString = searchText.replacingOccurrences(of: " ", with: "%20")
        getPlaceFromSearch(input: newSearchString) {
            
        }
        } else {
            downloadPlaces {
                
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func downloadPlaces(completed: @escaping DownloadComplete) {
        
        places.removeAll()
        
        let forecastUrl = URL(string: test_url)
        Alamofire.request(forecastUrl!).responseJSON {response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let placesResult = dict["results"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in placesResult {
                        
                        var name = ""
                        var address = ""
                        var placeId = ""
                        
                        if let placeName = obj["name"] as? String {
                            name = placeName
                        }
                        
                        if let placeAddress = obj["vicinity"] as? String {
                            address = placeAddress
                        }
                        
                        if let finalPlaceId = obj["place_id"] as? String {
                            placeId = finalPlaceId
                        }
                        
                        let place = PlaceLight(id: placeId, name: name, address: address)
                        
                        
                        self.places.append(place)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
            completed()
        }
        
    }
    
    func getPlaceFromSearch(input:String, completed: @escaping DownloadComplete){
        
        places.removeAll()
        
        let forecastUrl = URL(string: "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE&input=\(input)&types=establishment&location=41.390205,2.154007&radius=500")
        Alamofire.request(forecastUrl!).responseJSON {response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let placesResult = dict["predictions"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in placesResult {
                        
                        var name = ""
                        var address = ""
                        var placeId = ""
                        
                        if let finalPlaceId = obj["place_id"] as? String {
                            placeId = finalPlaceId
                        }
                        
                        if let placesData = obj["structured_formatting"] as? Dictionary<String, AnyObject> {
                            
                            if let placeName = placesData["main_text"] as? String {
                                name = placeName
                            }
                            
                            if let placeAddress = placesData["secondary_text"] as? String {
                                address = placeAddress
                            }
                            
                        }
                        
                        let place = PlaceLight(id: placeId, name: name, address: address)
                        
                        
                        self.places.append(place)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
            completed()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination as UIViewController
        toViewController.transitioningDelegate = self.transitionManager
        
        if segue.identifier == "showPlaceAdd" {
            
            if let detailsVC = segue.destination as? PlacePreviewVC {
                
                if let place = sender as? PlaceLight {
                    
                    detailsVC.place = place
                    
                }
                
            }
            
        }
    }

}
