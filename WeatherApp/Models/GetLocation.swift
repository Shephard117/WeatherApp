//
//  GetLocation.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 25.12.2021.
//

import Foundation
import CoreLocation

let weatherManager = WeatherManager()

func getCityWeather(cities: [String], completionHandler: @escaping (Int, WeatherModel) -> Void ){
    
    for (index, city) in cities.enumerated() {
        findCity(city: city) { coordinate, error in
            guard let coordinate = coordinate else { return }
            weatherManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { weatherModel in
                print(weatherModel.temp)
                completionHandler(index, weatherModel)
            }
        }
    }
}

func findCity(city: String, handler: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()){
    CLGeocoder().geocodeAddressString(city) { placemarks, error in
        if error == nil {
            if let placemark = placemarks?.first {
                let location = placemark.location
                handler(location?.coordinate, nil)
                return
                
            }
        }
    }
}

