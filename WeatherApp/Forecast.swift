//
//  Forecast.swift
//  WeatherApp
//
//  Created by Jesus Gomez on 7/10/17.
//  Copyright © 2017 gomezja. All rights reserved.
//

import UIKit
import Alamofire


// forcast
class Forecast {
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        // get min and max temperatures of the day
        if let temp = weatherDict["main"] as? Dictionary<String, AnyObject> {
            if let min = temp["temp_min"] as? Double {
                // convert from kelvin to farenheit
                let kelvinToFarenheitPreDivision = (min * (9/5) - 459.67)
                    
                let KelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._lowTemp = "\(KelvinToFarenheit)"
            }
            
            if let max = temp["temp_max"] as? Double {
                // convert from kelvin to farenheit
                let kelvinToFarenheitPreDivision = (max * (9/5) - 459.67)
                
                let KelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                
                self._highTemp = "\(KelvinToFarenheit)"
            }
        }
        
        // get day's weather type
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main.capitalized
            }
        }
        
        // get day
        if let date = weatherDict["dt"] as? Double {
            let unixCovertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .medium
            let str = "\(dateFormatter.string(from: unixCovertedDate))"
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            self._date = "\(unixCovertedDate.daysOfTheWeek()) \(str)"
        }
    }
}

extension Date {
    func daysOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
