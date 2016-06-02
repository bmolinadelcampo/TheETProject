//
//  WeatherApiController.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 17/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import Foundation
import UIKit

let autocompleteUrl = "http://autocomplete.wunderground.com/aq?query="
let apiUrl = "http://api.wunderground.com/api"
let apiKey = "5bddb04ec22bd4fa"

class WeatherApiController {
    
    let session = NSURLSession.sharedSession()
    var ongoingDataTask: NSURLSessionDataTask?
    
    
    //MARK - Calls
    
    func autocompletePlaceNameForString(searchString: String, completion: (suggestedPlaces: [Place]?) -> Void)
    {
        
        if let dataTask = ongoingDataTask {
            
            dataTask.cancel()
        }
        
        guard let encodedString = searchString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()),
            fullUrl = NSURL(string: autocompleteUrl + encodedString)
            
            else {
                
                print("Error: could not compose url to autocomplete search")
                
                completion(suggestedPlaces: nil)
                return
        }
        
        ongoingDataTask = session.dataTaskWithURL(fullUrl, completionHandler: { (data, response, error) -> Void in
            
            if error == nil && (response as! NSHTTPURLResponse).statusCode == 200 {
                
                if let data = data {
                    
                    completion(suggestedPlaces: self.parseAutocompleteJson(data) as [Place]?)
                    return
                }
                
            }
            
            completion(suggestedPlaces: nil)
            return
            
        })
        
        ongoingDataTask?.resume()
        
    }
    
    func fetchTodayWeatherConditionsForPlace(place: HappyPlace, completion: (weather: Weather?) -> Void)
    {
        guard let url = composeUrlForPlace(place)
            else
        {
            print("Error: Could not compose url to fetch today weather conditions")
            
            completion(weather: nil)
            return
        }
        
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            if error == nil && (response as! NSHTTPURLResponse).statusCode == 200 {
                
                if let data = data {
                    
                    completion(weather: self.parseTodayWeatherJson(data) as Weather?)
                    return
                }
            }
            
            completion(weather: nil)
            return
        })
        
        task.resume()
    }
    
    func fetchIconForWeather(weather: Weather, completion: (icon: UIImage?) -> Void) {
        
        if let url = weather.iconUrl {
            
            let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let data = data {
                    
                    completion(icon: UIImage(data: data))
                    
                } else {
                    
                    completion(icon: nil)
                }
            }
            
            task.resume()
            
        } else {
            
            completion(icon: nil)
        }
        
    }
    // MARK - Compose url methods
    
    private func composeUrlForPlace(place: HappyPlace) -> NSURL?
    {
        let featureString = "conditions"
        
        if let country = place.country, name = place.name {
            
            let queryString = "q/\(country)/\(name)"
            let formatString = ".json"
            
            let fullQueryString = queryString + formatString
            
            let url = NSURL(string: apiUrl)?.URLByAppendingPathComponent(apiKey).URLByAppendingPathComponent(featureString).URLByAppendingPathComponent(fullQueryString)
            
            return url
        }
        
        return nil

    }
    
    
    // MARK: - Parsing methods 
    
    private func parseAutocompleteJson(data: NSData) -> [Place]?
    {
        do {
            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject] {
                
                var suggestedPlacesArray = [Place]()
                
                for placeDictionary: [String: AnyObject] in (json["RESULTS"] as? [[String: AnyObject]])!
                {
                    if Place.isCity(placeDictionary) {
                        
                        suggestedPlacesArray.append(Place(dictionary: placeDictionary))
                    }
                }
                
                return suggestedPlacesArray
            }
        } catch {
            
            print("Error: could not serialise autocomplete json")
        }
        
        return nil
    }
    
    private func parseTodayWeatherJson(data: NSData) -> Weather?
    {
        do {
            
            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject] {
                
                let weather = Weather(dictionary: json)
                
                print("Data received")
                
                return weather
            }
            
        }catch{
            
            print("Error: could not serialise today weather conditions json")
        }
        
        return nil
    }
    
}
