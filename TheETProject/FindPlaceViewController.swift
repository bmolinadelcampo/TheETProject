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
    
    var selectedPlace: Place?
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
                tableViewController.delegate = self
            }
        }
        
        if segue.identifier == "showPlaceInfo" {
            
            let destinationViewController = segue.destinationViewController as! CityTabBarController
            destinationViewController.place = sender as! Place
        }
    }
}

extension FindPlaceViewController: AddButtonDelegate {
    
    
    func showAddButton(selectedPlace: Place) {
        
        let addButton: UIButton = UIButton(frame: CGRectMake(150, 180, 100, 30))
        
        addButton.backgroundColor = UIColor(red:0.92, green:0.37, blue:0.36, alpha:1.00)
        addButton.layer.cornerRadius = 8
        addButton.setTitle("Go!", forState: UIControlState.Normal)
        addButton.tag = 1
        
        addButton.addTarget(self, action: "addButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(addButton)
        
        self.selectedPlace = selectedPlace
        citySearchBar.text = selectedPlace.name + ", " + selectedPlace.country

    }
    
    func removeAddButton() {
        
        let subviews = self.view.subviews as [UIView]
        
        for view in subviews {
            
            if let button = view as? UIButton {
                
                if button.tag == 1 {
                    
                    button.removeFromSuperview()
                }
            }
        }
    }

    func addButtonPressed() {
        
        print("Add")
        if let selectedPlace = self.selectedPlace {
            performSegueWithIdentifier("showPlaceInfo", sender: selectedPlace)
        }
    }
}
