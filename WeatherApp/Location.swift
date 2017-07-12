//
//  Location.swift
//  WeatherApp
//
//  Created by Jesus Gomez on 7/12/17.
//  Copyright © 2017 gomezja. All rights reserved.
//

import CoreLocation

// singleton class
public class Location {
    static var sharedInstance = Location()
    
    private init() {
        
    }
    
    var latitude: Double!
    var longitude: Double!
}
