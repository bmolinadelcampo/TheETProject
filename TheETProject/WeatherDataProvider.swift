//
//  WeatherDataProvider.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 25/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import Foundation

class WeatherDataProvider
{
    var weather: Weather!
    var place: Place!
    var dateFormatter: NSDateFormatter!
    
    init(place: Place, weather: Weather)
    {
        self.weather = weather
        self.place = place
        
        self.dateFormatter = NSDateFormatter()
        
        print(dateFormatter.timeZone.name)
        dateFormatter.timeZone = place.timeZone
        dateFormatter.dateFormat = "hh:mm"
    }
    
    func formatWeatherDescription() -> String?
    {
        return weather.weatherDescription
    }
    
    func formatCurrentTemperature() -> String?
    {
        if let temperature = weather.temperature {
            
            return String(temperature) + "°C"
        }
        
        return nil
    }
    
    func formatPlace() -> String?
    {
        return place.name + ", " + place.country
    }
    
    func formatLocalTime() -> String?
    {
        return dateFormatter.stringFromDate(NSDate())
        
    }
}
