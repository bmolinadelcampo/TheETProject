//
//  Place.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 16/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Place {
    
    var name: String?
    var country: String?
    var location: CLLocation?
    var timeZone: NSTimeZone?
    
    class func isCity(dictionary: [String: AnyObject]) -> Bool
    {
        if let placeName = dictionary["name"] as? String where placeName.rangeOfString(",") != nil {
            
            return true
        }
        
        return false
    }
    
    
    init(dictionary: [String: AnyObject]) {
                
        if let nameAndCountry = dictionary["name"] {
            
            let nameCountryArray = nameAndCountry.componentsSeparatedByString(", ")
            
            if nameCountryArray.count == 2 {
                
                self.name = nameCountryArray[0]
                self.country = nameCountryArray[1]
                
            }
        }
        
        if let latitudeString = dictionary["lat"] as? String, longitudeString = dictionary["lon"] as? String,
        latitude = Double(latitudeString), longitude = Double(longitudeString) {
            
            self.location = CLLocation(latitude: latitude, longitude: longitude)
        }
        
        if let timeZone = dictionary["tz"] as? String {
            
            self.timeZone = NSTimeZone(name: timeZone)
        }
    }
    
}
