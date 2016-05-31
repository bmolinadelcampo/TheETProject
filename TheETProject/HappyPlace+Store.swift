//
//  HappyPlace+Store.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 31/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import Foundation
import CoreData

extension HappyPlace {
    
    class func fetchAllHappyPlaces() -> NSFetchRequest {
        
        return fetchHappyPlacesWithPredicate(nil)
    }
    
    class func fetchHappyPlaceWithLocation(latitude: Double, longitude: Double) -> NSFetchRequest {
        
        return fetchHappyPlacesWithPredicate(NSPredicate(format: "latitude == %lf AND longitude == %lf", latitude, longitude))
    }
    
    private class func fetchHappyPlacesWithPredicate(predicate: NSPredicate?) -> NSFetchRequest {
        
        let request = NSFetchRequest(entityName: "HappyPlace")
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        
        return request
    }
}