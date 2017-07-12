//
//  Constants.swift
//  WeatherApp
//
//  Created by Jesus Gomez on 7/6/17.
//  Copyright © 2017 gomezja. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "9c53e58edc5459f4fc9e377db364fb1a"

// tells the function when downloading is complete
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)weather?\(LATITUDE)-33\(LONGITUDE)121\(APP_ID)\(APP_KEY)"
let FORECASTURL = "\(BASE_URL)forecast?\(LATITUDE)-33\(LONGITUDE)121\(APP_ID)\(APP_KEY)"

