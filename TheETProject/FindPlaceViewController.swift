//
//  FindPlaceViewController.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 10/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FindPlaceViewController: UIViewController  {
    
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var containerView: UIView!

    var tableViewController: LocationSearchTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citySearchBar.placeholder = "Search for places"
        
        setDefaultRegionForMapView(mapView)
    }
    
    @IBAction func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    func setDefaultRegionForMapView(mapView: MKMapView)
    {
        let defaultCenter: CLLocationCoordinate2D = CLLocationCoordinate2DMake(38.736946, -9.142685)
        let span = MKCoordinateSpanMake(180, 180)
        let region = MKCoordinateRegion(center: defaultCenter, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedTableView" {
            
            if let tableViewController = segue.destinationViewController as? LocationSearchTableViewController {
                citySearchBar.delegate = tableViewController
                tableViewController.mapView = mapView
            }
        }
    }
}

