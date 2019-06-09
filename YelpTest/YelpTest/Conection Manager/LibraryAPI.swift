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
    
    func searchBusinessesBy(term:String,  Success onSuccess:@escaping (SearchBusinessResponse) -> (), onError: @escaping (String) -> ()) {
        let params = ["term":term,
                      "location":"NYC"] as [String : Any]
        HTTPClient.sharedInstance.params = params as Dictionary<String, AnyObject>
        HTTPClient.sharedInstance.doRequest(method: "businesses/search", type: "GET", parameters: [:], onSuccess: {(data) in
            let responseData = SearchBusinessResponse(dictionary: data)
                onSuccess(responseData )
        }, onError: {(error) in
            onError(error.description)
            debugPrint(error.description)
        })
    }
    
}


