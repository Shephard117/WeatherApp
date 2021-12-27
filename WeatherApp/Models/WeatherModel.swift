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
    
    init?(name: String, temp: Int, feelsLike: Int, url: String, windSpeed: Double){
        self.name = name
        self.temp = temp
        self.feelsLike = feelsLike
        self.url = url
        self.windSpeed = windSpeed
    }
    
    init(){
        
    }
}
