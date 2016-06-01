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
                
                print("Error: Could not execute fetch request - fetchHappyPlaces()")
            }
        }
        
        placesArray = results
    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showContentForHappyPlace" {
            
            let destinationViewController = segue.destinationViewController as! CityTabBarController
            destinationViewController.place = sender as! HappyPlace
        }
    }
}

extension HappyPlacesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let placesArray = placesArray {
            
            return placesArray.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("happyPlaceCell") as! HappyPlacesTableViewCell
        
        if let place = placesArray?[indexPath.row] {
            
            cell.configureCell(place)
        }
        
        return cell
    }
}

extension HappyPlacesViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! HappyPlacesTableViewCell
        
        let selectedPlace = cell.place
        
        performSegueWithIdentifier("showContentForHappyPlace", sender: selectedPlace)
        
    }
}
