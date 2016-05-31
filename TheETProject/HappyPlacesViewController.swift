//
//  ViewController.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 02/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import UIKit

class HappyPlacesViewController: UIViewController {

    var placesArray: [HappyPlace]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHappyPlaces()
    }

    
    func fetchHappyPlaces() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        var results: [HappyPlace]?
        
        managedContext.performBlockAndWait { () -> Void in
            
            do {
                
                results = try managedContext.executeFetchRequest(HappyPlace.fetchAllHappyPlaces()) as? [HappyPlace]
                
            } catch {
                
                print("mohón")
            }
        }
        
        placesArray = results
    }
}

