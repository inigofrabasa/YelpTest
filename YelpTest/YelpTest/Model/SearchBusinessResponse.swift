//
//  SearchBusinessResponse.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

class SearchBusinessResponse: NSObject {
    var busisess : [Business]
    var total : Int
    
    init(dictionary: Dictionary<String, AnyObject>) {
        busisess = Utility.getArrayOfBusiness(dictionary: dictionary["businesses"] as! [Dictionary<String, AnyObject>])
        total = dictionary["total"] as? Int ?? 0
    }
    
    
}
