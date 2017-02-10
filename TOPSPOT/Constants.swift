//
//  Constants.swift
//  TOPSPOT
//
//  Created by Ludo on 10/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import Foundation

let api_key = "AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE"
let base_nearby_search_url:String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
let base_text_search_url:String = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
let base_details_url:String = "https://maps.googleapis.com/maps/api/place/details/json?"
let base_photos_url:String = "https://maps.googleapis.com/maps/api/place/photo?"

typealias DownloadComplete = () -> ()
