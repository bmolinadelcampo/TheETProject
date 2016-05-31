//
//  Weather.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 17/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import Foundation

class Weather {
    
    var weatherDescription: String?
    var temperature: Int?
    var iconString: String?
    var iconUrl: NSURL?
    var localTime: NSDate?
    
    init(dictionary: [String: AnyObject]) {
        
        guard let currentConditionsDictionary = dictionary["current_observation"] else { return }
        
        if let weatherDescription = currentConditionsDictionary["weather"] {
            
            self.weatherDescription = weatherDescription as? String
        }
        
        if let temperature = currentConditionsDictionary["temp_c"] {
            
            self.temperature = temperature as? Int
        }
        
        if let iconString = currentConditionsDictionary["icon"] {
            
            self.iconString = iconString as? String
        }
        
        if let iconUrl = currentConditionsDictionary["icon_url"] as? String {
            
            self.iconUrl = NSURL(string: iconUrl)
        }
    }
}