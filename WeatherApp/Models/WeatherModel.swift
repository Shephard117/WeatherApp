//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 25.12.2021.
//

import Foundation

struct WeatherModel {
    var name: String = ""
    var temp: Int = 0
    var feelsLike: Int = 0
    var url: String = ""
    var windSpeed: Double = 0
    var temperatureString: String {
        return String(temp)
    }
    var condition: String = ""
    var conditionRU: String {
        switch condition {
        case "clear":
            return "Ясно"
        case "cloudy":
            return "Облачно"
        case "light-snow":
            return "Легкий снег"
        case "overcast":
            return "Пасмурно"
        case "partly-cloudy":
            return "Легкая облачность"
        case "snow":
            return "Снег"
            
        default:
            return "Невозможно определить"
        }
        
    }
    
    init?(name: String, temp: Int, feelsLike: Int, url: String, windSpeed: Double, condition: String){
        self.name = name
        self.temp = temp
        self.feelsLike = feelsLike
        self.url = url
        self.windSpeed = windSpeed
        self.condition = condition
    }
    
    init(){
        
    }
}
