//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jesus Gomez on 7/5/17.
//  Copyright © 2017 gomezja. All rights reserved.
//

import UIKit
import CoreLocation     // to get user's location auto
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManger = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // location delegate
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest    // accuracy of location
        locationManger.requestWhenInUseAuthorization()      // use location only when in use
        locationManger.startMonitoringSignificantLocationChanges()

        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()    // call function to request and get location
    }
    
    // location function to request and save user location
    // info.plist to modify location request
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManger.location   // get current location
            
            // save location coordinates
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManger.requestWhenInUseAuthorization()
            locationAuthStatus()    // if request is approved. . .
        }
    }
    
    func downloadForecastData(Completed: @ escaping DownloadComplete) {
        // downloading forecast weather data for tableview
        Alamofire.request(FORECASTURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    //self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            Completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // how many cells in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.currentTemp)"   // convert double to string
        currentWeatherType.text = currentWeather.weatherType
        locationLbl.text = currentWeather._cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
}

