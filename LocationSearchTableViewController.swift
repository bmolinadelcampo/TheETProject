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

class LocationSearchTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var selectedPlace: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView(tableView)
    }

    // MARK: - Table view data source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath) as! PlaceTableViewCell

        cell.configureCell(matchingItems[indexPath.row].placemark)
        return cell
    }
    
    func configureTableView(tableView: UITableView) {
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = UIColor(red:0.92, green:0.37, blue:0.36, alpha:1.00)
    }
}


extension LocationSearchTableViewController : UISearchBarDelegate {

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            
            matchingItems = []
            tableView.reloadData()
            
        } else {
            
            guard let searchBarText = searchBar.text else { return }
            
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = searchBarText
            
            let search = MKLocalSearch(request: request)
            
            search.startWithCompletionHandler { response, _ in
              
                guard let response = response else {
                    return
                }
                print("There are \(response.mapItems.count) matching items")

                self.matchingItems = response.mapItems.filter(self.isCity)
                print("Matching items are: \(self.matchingItems)")
                self.tableView.reloadData()
            }
        }
    }
    
    func isCity(mapItem: MKMapItem) -> Bool {
        return mapItem.placemark.name == mapItem.placemark.locality
    }
    
}

extension LocationSearchTableViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! PlaceTableViewCell
        
        selectedPlace = Place(placemark: cell.placemark)
    }
}

