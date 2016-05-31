//
//  LocationSearchTableViewController.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 12/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol AddButtonDelegate {
    
    func showAddButton(selectedPlace: Place)
    func removeAddButton()
}

class LocationSearchTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var matchingItems:[Place] = []
    var mapView: MKMapView? = nil
    var delegate: AddButtonDelegate!
    var apiController: WeatherApiController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView(tableView)
        
        apiController = WeatherApiController()
    }

    // MARK: - Table view data source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if matchingItems.count == 0 {
            
            tableView.hidden = true
            
        } else {
            
            tableView.hidden = false
        }
        
        return matchingItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath) as! PlaceTableViewCell

        cell.configureCell(matchingItems[indexPath.row])
        return cell
    }
    
    func configureTableView(tableView: UITableView) {
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = UIColor(red:0.92, green:0.37, blue:0.36, alpha:1.00)
    }
}


extension LocationSearchTableViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count < 3 {
            
            matchingItems = []
            tableView.reloadData()
            delegate.removeAddButton()
            
        } else {
            
            apiController?.autocompletePlaceNameForString(searchText, completion: { (suggestedPlaces) -> Void in
                
                if let suggestedPlaces = suggestedPlaces {
                    
                    self.matchingItems = suggestedPlaces
                    
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        
                        self.tableView.reloadData()
                        
                    }
                }
            })
        }
    }
}

extension LocationSearchTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! PlaceTableViewCell
        
        let selectedPlace = cell.place
        
        tableView.hidden = true
        
        delegate.showAddButton(selectedPlace)
    }

}
