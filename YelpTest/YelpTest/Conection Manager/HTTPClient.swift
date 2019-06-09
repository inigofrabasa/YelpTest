//
//  HTTPClient.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import Foundation

class HTTPClient: NSObject {
    
    static let sharedInstance = HTTPClient()
    
    private let SERVER = "https://api.yelp.com/v3/"
    
    
    
    private let session: URLSession
    private let config: URLSessionConfiguration
    
    private var request: NSMutableURLRequest?
    
    var params : Dictionary <String,AnyObject>?
    var needHeaders: Bool?
    
    
    override init(){
        config = URLSessionConfiguration.default
        
        session = URLSession(configuration: config)
        
        
    }
    
    func doRequest(method: String, type: String, parameters: Dictionary<String, AnyObject>?, onSuccess: @escaping ([String:AnyObject]) -> (), onError: @escaping (NSError) -> ()) {
        
        prepareRequestWithMethod(method: method, type: type)
        
        if parameters != nil {
            do {
                request!.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: [])
                // use anyObj here
            } catch {
                request!.httpBody = "".data(using: String.Encoding.utf8, allowLossyConversion: false)
            }
        } else {
            request!.httpBody = "".data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        
        
        
        var task = URLSessionDataTask()
        task = session.dataTask(with: request! as URLRequest, completionHandler: {(data, response, error) in
            //print("DataTask didEnd")
            
            if error != nil {
                onError(error! as NSError)
                return
            }
            let httpResponse = response as! HTTPURLResponse
            if (httpResponse.statusCode != 200) {
                //print("Received HTTP StatusCode: \(httpResponse.statusCode)")
                onError(NSError(domain: "Unexpected", code: httpResponse.statusCode, userInfo: [:]))
                return
            }
            
            var responseObject: [String:AnyObject] = [:]
            
            if (data?.count)! > 0 {
                
                do {
                    if let dictionaryOK = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        
                        responseObject = dictionaryOK as [String:AnyObject]
                        // print(responseObject ?? "Empty Object")
                    }
                } catch {
                    print(error)
                }
            }
            
            onSuccess(responseObject)
        })
        task.resume()
    }
    
    
    func doRequest(method: String, parameters: Dictionary<String, AnyObject>, onSuccess: @escaping ([String:AnyObject]) -> Void, onError: @escaping (NSError) -> Void) {
        
        doRequest(method: method, type: "POST", parameters: parameters, onSuccess: onSuccess , onError: onError)
    }
    
    
    func prepareRequestWithMethod(method: String, type: String) {
        var url = NSURL(string: "\(SERVER)\(method)")
        if (params != nil){
           url =  url?.URLByAppendingQueryParameters(parametersDictionary: params! as! Dictionary<String, String>)
        }
        request = NSMutableURLRequest(url: url! as URL)
        request!.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request!.addValue("Bearer Qm-Pji8vasBCwf1A73PPkINVB7bYGWR_81MNkvPE5KkvmHNaSTl7gi03lmmCaavWkK_XRs8pyQk8lk0EZdBEODbZHM9mi9a4RxmCFmZmrbpnAAcknkSm0V9QHyn9XHYx", forHTTPHeaderField: "Authorization")
        
        request!.httpMethod = type as String
        request!.timeoutInterval = 30
    }
    
    
    func stringFromQueryParameters(queryParameters : Dictionary<String, AnyObject>) -> String {
        var parts: [String] = []
        for (name, value) in queryParameters {
            let part = NSString(format: "%@=%@",name.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!,value.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)
            
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = NSString(format: "%@=%@",
                                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension NSURL {
    /**
     Creates a new URL by adding the given query parameters.
     @param parametersDictionary The query parameter dictionary to add.
     @return A new NSURL.
     */
    func URLByAppendingQueryParameters(parametersDictionary : Dictionary<String, String>) -> NSURL {
        let URLString : NSString = NSString(format: "%@?%@", self.absoluteString!, parametersDictionary.queryParameters)
        return NSURL(string: URLString as String)!
    }
}

