//
//  WeatherViewController.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 10/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import UIKit

class WeatherViewController: ContentViewController {

    @IBOutlet weak var weatherDescriptionImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var CurrentTemperatureLabel: UILabel!
    @IBOutlet weak var localTimeLabel: UILabel!
    
    var dataProvider: WeatherDataProvider!
    var apiController: WeatherApiController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiController = WeatherApiController()
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        loadData()
    }
    
    func loadData()
    {
        apiController.fetchTodayWeatherConditionsForPlace(place) { (weather) -> Void in
            
            guard let weather = weather else {
                
                print("Error: WeatherApiController didn't return a valid weather object")
                return
            }
            
            self.dataProvider = WeatherDataProvider(place: self.place, weather: weather)
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                
                self.populateLabels()
            }
        }

    }
    
    func populateLabels()
    {
        if let weatherDescriptionString = dataProvider.formatWeatherDescription() {
            
            weatherDescriptionLabel.text = weatherDescriptionString
            
        } else {
            
            weatherDescriptionLabel.text = ""
        }
        
        if let currentTemperatureString = dataProvider.formatCurrentTemperature() {
            
            CurrentTemperatureLabel.text = currentTemperatureString
            
        } else {
            
            CurrentTemperatureLabel.text = "-"
        }
        
        if let placeString = dataProvider.formatPlace() {
            
            placeLabel.text = placeString
            
        } else {
            
            placeLabel.text = ""
        }

        if let localTime = dataProvider.formatLocalTime() {
            
            localTimeLabel.text = localTime
            
        } else {
            
            localTimeLabel.text = "-:-"
        }
    }
}
