//
//  Coordinate.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import Foundation

public class Coordinate {
    
    var latitude: Double
    var longitude: Double
    
    init(dictionary: Dictionary<String, AnyObject>){
        latitude = dictionary["latitude"] as? Double ?? 0.0
        longitude = dictionary["longitude"] as? Double ?? 0.0

    }
    
}
