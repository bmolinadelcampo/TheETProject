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
    
    var name: String!
    var country: String!
    var location: CLLocation!
    var timeZone: NSTimeZone!
    
    init(placemark: MKPlacemark) {
        
        if let name = placemark.locality {
            
            self.name = name
        }
        
        if let country = placemark.country {
            
            self.country = country
        }
        
        if let location = placemark.location {
            
            self.location = location
        }
        
        if let timeZone = placemark.timeZone {
            
            self.timeZone = timeZone
        }
    }
}
