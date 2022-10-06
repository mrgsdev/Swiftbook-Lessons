//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by MRGS on 07.10.2022.
//

import Foundation
protocol NetworkWeatherManagerDelegate:AnyObject {
    func update(_: NetworkWeatherManager,with currentWeather:CurrentWeather)
}

class NetworkWeatherManager {
    
   weak var delegate:NetworkWeatherManagerDelegate?
    func fetchCurrentWeather(forCity city:String) {
        // API
        let apiKey = "9da98dc83df80ab8c815947f4f92cf1a"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.pasrseJSON(withData: data){
                    self.delegate?.update(self, with: currentWeather)
                }
            }
        }
        task.resume()
    }
    func pasrseJSON(withData data:Data) -> CurrentWeather? {
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
