//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by MRGS on 07.10.2022.
//

import Foundation
import CoreLocation
class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        // API
        let apiKey = "9da98dc83df80ab8c815947f4f92cf1a"
        var urlString = ""
        switch requestType {
        case .cityName(let city):
          urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
            
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
   
    
    
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.pasrseJSON(withData: data){
                    self.onCompletion?(currentWeather)
                    print(currentWeather)
                }
            
            }
  
        }
        task.resume()
    }
    
    
    fileprivate func pasrseJSON(withData data:Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do{
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        return nil
    }
}
