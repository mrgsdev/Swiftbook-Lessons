//
//  ViewController.swift
//  WeatherApp
//
//  Created by MRGS on 07.10.2022.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    var networkWeatherManager = NetworkWeatherManager()
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        return locationManager
    }()
    
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
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
        }
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
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude 
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
