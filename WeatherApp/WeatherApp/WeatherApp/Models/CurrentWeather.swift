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
        return  "\(temperature.rounded())"
    }
    
    
    let feelsLikeTemperature:Double
    var feelsLikeTemperatureString:String{
        return  "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode:Int

    init?(currentWeatherData:CurrentWeatherData){
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
