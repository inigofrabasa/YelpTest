//
//  Utility.swift
//  YelpTest
//
//  Created by Iñigo Flores Rabasa on 6/9/19.
//  Copyright © 2019 Iñigo Flores Rabasa. All rights reserved.
//

import UIKit
import MapKit

public class Utility {
    
    class func getArrayOfBusiness (dictionary : [Dictionary<String, AnyObject>]) -> [Business] {
        var productsArray : [Business] = []
        
        for element in dictionary {
            let business = Business(dictionary: element)
            productsArray.append(business)
        }
        return productsArray
    }
    
    class func setStatusLabel(label:UILabel, isClosed:Bool){
        
        let color = isClosed == true ? UIColor.red : UIColor.green
        let text = isClosed == true ? "Closed" : "Open"

        label.textColor = color
        label.text = text
    }
    
    class func setupMapView(mapview:MKMapView, locationData: Coordinate){
        let location = CLLocationCoordinate2D(latitude: locationData.latitude, longitude: locationData.longitude)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        let bussinesPin = MKPointAnnotation()
       
        bussinesPin.coordinate = CLLocationCoordinate2D(latitude: locationData.latitude, longitude: locationData.longitude)
        mapview.addAnnotation(bussinesPin)
        
        mapview.setRegion(region, animated: true)
    
    }
    
}
