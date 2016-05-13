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

class LocationSearchTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.clearColor()
        
    }

    // MARK: - Table view data source

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath)

        configureCell(cell, placemark: matchingItems[indexPath.row].placemark)
        return cell
    }

    func configureCell(cell: UITableViewCell, placemark: CLPlacemark) {
        cell.textLabel?.text = placemark.locality
        cell.detailTextLabel?.text = placemark.country
        cell.backgroundColor = UIColor.clearColor()
    }
}


extension LocationSearchTableViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {


    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            
            matchingItems = []
            tableView.reloadData()
            
        } else {
            
            guard let mapView = mapView,
                let searchBarText = searchBar.text else { return }
            
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = searchBarText
            request.region = mapView.region
            
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
