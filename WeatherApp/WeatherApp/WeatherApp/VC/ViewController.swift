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
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self] cityName in
            guard let selfStrong = self else { return }
            selfStrong.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { currentWeather in
            self.updateUI(weather: currentWeather)
        }
        networkWeatherManager.fetchCurrentWeather(forCity: "Moscow")
    }

}
extension ViewController{
    private func updateUI(weather: CurrentWeather)   {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}
