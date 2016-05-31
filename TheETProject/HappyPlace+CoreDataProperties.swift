//
//  HappyPlace+CoreDataProperties.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 31/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HappyPlace {

    @NSManaged var name: String?
    @NSManaged var country: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var timeZoneName: String?

}
