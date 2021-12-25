//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Дмитрий Скоробогаты on 25.12.2021.
//

import Foundation


struct WeatherData: Codable {
    let info: Info
    let fact: Fact
//    let forecasts: [Forecast]
}

struct Info: Codable {
    let url: String
}

struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let icon: Icon
    let condition: Condition
   let windSpeed: Double
    let pressureMm: Int
    
    enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case windSpeed = "wind_speed"
            case pressureMm = "pressure_mm"
            case icon
            case condition
        }
}
//
enum Condition: String, Codable {
    case clear = "clear"
    case cloudy = "cloudy"
    case lightSnow = "light-snow"
    case overcast = "overcast"
    case partlyCloudy = "partly-cloudy"
    case snow = "snow"
}
//
enum Icon: String, Codable {
    case bknD = "bkn_d"
    case bknN = "bkn_n"
    case iconOvcSn = "ovc_sn"
    case ovc = "ovc"
    case ovcSn = "ovc_-sn"
    case skcD = "skc_d"
    case skcN = "skc_n"
}
//
//// MARK: - Forecast
//struct Forecast: Codable {
//    let date: String
//    let dateTs, week: Int
//    let sunrise, sunset, riseBegin, setEnd: String
//    let moonCode: Int
//    let moonText: String
//    let hours: [Fact]
//
//    enum CodingKeys: String, CodingKey {
//        case date
//        case dateTs
//        case week, sunrise, sunset
//        case riseBegin
//        case setEnd
//        case moonCode
//        case moonText
//        case hours
//    }
//}
