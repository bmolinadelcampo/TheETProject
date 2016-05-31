//
//  WeatherApiController.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 17/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import Foundation

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
    
    func fetchTodayWeatherConditionsForPlace(place: Place, completion: (weather: Weather?) -> Void)
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
    
    // MARK - Compose url methods
    
    private func composeUrlForPlace(place: Place) -> NSURL?
    {
        let featureString = "conditions"
        let queryString = "q/\(place.country)/\(place.name)"
        let formatString = ".json"
        
        let fullQueryString = queryString + formatString
        
        let url = NSURL(string: apiUrl)?.URLByAppendingPathComponent(apiKey).URLByAppendingPathComponent(featureString).URLByAppendingPathComponent(fullQueryString)
        
        return url
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
