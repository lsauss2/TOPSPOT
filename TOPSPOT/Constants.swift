//
//  Constants.swift
//  TOPSPOT
//
//  Created by Ludo on 10/02/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import Foundation

let KEY_UID = "uid"

let test_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE&location=41.390205,2.154007&radius=500&types=bar"

let test_photo_url = "https://maps.googleapis.com/maps/api/place/photo?key=AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE&photoreference=CoQBdwAAAET75GGfPyZ03LhH_L_sdOMjWfsDjT78kkKVqEeppwq2V0bTCruo90BpmgAd1iyFkHr3eyEiHEB5JV8ZYVvE6sFnFXnmWPsipmMi683OAuwrjfPAU4AhBjym2OM8YXR7-_o-kf3XKhsr1vQHsYbhDcFIvUiMi7XYr7x0_FqlpiuuEhBnAn_U6I-i9qA2gAnmZVQmGhR7ItPKHj0IcGzGWp8D0x51cUql_A&maxwidth=400"

let api_key = "AIzaSyDDzFcsajCTfbIGYMCZwKKGu8y1IPk9GyE"
let base_nearby_search_url:String = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
let base_text_search_url:String = "https://maps.googleapis.com/maps/api/place/textsearch/json?"
let base_details_url:String = "https://maps.googleapis.com/maps/api/place/details/json?"
let base_photos_url:String = "https://maps.googleapis.com/maps/api/place/photo?"

typealias DownloadComplete = () -> ()
