//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 25.12.2021.
//

import Foundation

struct WeatherManager {
    
    func fetchWeather(latitude: Double, longitude: Double, handler: @escaping (WeatherModel) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let safeData = data else { return }
            if let weather = parseJSON(from: safeData){
                handler(weather)
            
            }
        }
        
        task.resume()
    }
    
    func parseJSON(from weatherData: Data) -> WeatherModel? {
       
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = "Example"
            let temp = decodedData.fact.temp
            let feelsLike = decodedData.fact.feelsLike
            let url = decodedData.info.url
            let windSpeed = decodedData.fact.windSpeed
            let condition = decodedData.fact.condition
            let pressure = decodedData.fact.pressureMm
            let weather = WeatherModel(name: name, temp: temp, feelsLike: feelsLike, url: url, windSpeed: windSpeed, condition: condition.rawValue, pressuer: pressure)
            return weather
        } catch {
            
            print("Что-то пошло не так! \(error.localizedDescription)")
            return nil
        }
    }
}
