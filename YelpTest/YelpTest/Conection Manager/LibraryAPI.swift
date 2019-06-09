//
//  LibraryAPI.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import Foundation


class LibraryAPI {
    
    static let sharedInstance = LibraryAPI()
    
    func searchBusinessesBy(term:String,  Success onSuccess:@escaping (Dictionary<String, AnyObject>) -> (), onError: @escaping (String) -> ()) {
        let params = ["term":term,
                      "location":"NYC"] as [String : Any]
        HTTPClient.sharedInstance.params = params as Dictionary<String, AnyObject>
        HTTPClient.sharedInstance.doRequest(method: "businesses/search", type: "GET", parameters: [:], onSuccess: {(data) in
            if let info = data as [String:Any]? {
                onSuccess(info as Dictionary<String, AnyObject>)
            } else {
                onError("Missing Info")
                debugPrint("Missing Info")
            }
        }, onError: {(error) in
            onError(error.description)
            debugPrint(error.description)
        })
    }
    
}


