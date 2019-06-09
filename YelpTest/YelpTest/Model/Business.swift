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
    var name : String
    var image: String
    var isClose : Bool
    var rating : Double
    var price : String
    var phone : String
    var website : String
    
    init(dictionary: Dictionary<String, AnyObject>) {
        id = dictionary["id"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        image = dictionary["image_url"] as? String ?? ""
        isClose = dictionary["is_closed"] as? Bool ?? false
        rating = dictionary["rating"] as? Double ?? 0.0
        price = dictionary["price"] as? String ?? ""
        phone = dictionary["display_phone"] as? String ?? ""
        website = dictionary["url"] as? String ?? ""
    }
}
