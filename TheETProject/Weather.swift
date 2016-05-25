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
    var temperature: String?
    var iconString: String?
    var iconUrl: NSURL?
    
    func initWithDictionary(dictionary: [String: AnyObject]) {
        
        if let weatherDescription = dictionary["weather"] {
            
            self.weatherDescription = weatherDescription as? String
        }
        
        if let temperature = dictionary["temp_c"] {
            
            self.temperature = temperature as? String
        }
        
        if let iconString = dictionary["icon"] {
            
            self.iconString = iconString as? String
        }
        
        if let iconUrl = dictionary["icon_url"] as? String {
            
            self.iconUrl = NSURL(string: iconUrl)
        }
    }
}