//
//  Business.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasaon 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

class Business: NSObject {
    var id : String
    var alias : String
    var name : String
    var image: String
    var isClose : Bool
    var isCalimed : Bool
    var rating : Double
    var price : String
    var displayPhone : String
    var phone : String
    var website : String
    var reviewCount: Int
    var photos : [String]
    
    init(dictionary: Dictionary<String, AnyObject>) {
        id = dictionary["id"] as? String ?? ""
        alias = dictionary["alias"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        image = dictionary["image_url"] as? String ?? ""
        isClose = dictionary["is_closed"] as? Bool ?? false
        isCalimed = dictionary["is_claimed"] as? Bool ?? false
        rating = dictionary["rating"] as? Double ?? 0.0
        price = dictionary["price"] as? String ?? ""
        phone = dictionary["phone"] as? String ?? ""
        displayPhone = dictionary["display_phone"] as? String ?? ""
        website = dictionary["url"] as? String ?? ""
        reviewCount = dictionary["review_count"] as? Int ?? 0
        photos = dictionary["photos"] as? [String]  ?? []
    }
}
