//
//  ViewController.swift
//  WeatherApp
//
//  Created by MRGS on 07.10.2022.
//

import UIKit

class ViewController: UIViewController {
    var networkWeatherManager = NetworkWeatherManager()
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { cityName in
            self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { currentWeather in
            print("onCompletion \(currentWeather.cityName)")
            
        }
        networkWeatherManager.fetchCurrentWeather(forCity: "Moscow")
    }

}

