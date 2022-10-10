//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by MRGS on 07.10.2022.
//

import Foundation
struct CurrentWeather {
    var cityName:String
    
    let temperature:Double
    var temperatureString:String{
        return  "\(Int(temperature))"
    }
    
    
    let feelsLikeTemperature:Double
    var feelsLikeTemperatureString:String{
        return  "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode:Int
    
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(currentWeatherData:CurrentWeatherData){
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
