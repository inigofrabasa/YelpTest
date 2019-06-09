//
//  Utility.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit

public class Utility {
    
    class func getArrayOfBusiness (dictionary : [Dictionary<String, AnyObject>]) -> [Business] {
        var productsArray : [Business] = []
        
        for element in dictionary {
            let business = Business(dictionary: element)
            productsArray.append(business)
        }
        return productsArray
    }
    
}
