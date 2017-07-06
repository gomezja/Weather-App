//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jesus Gomez on 7/5/17.
//  Copyright © 2017 gomezja. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherType: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

