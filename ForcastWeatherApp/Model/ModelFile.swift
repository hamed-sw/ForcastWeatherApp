//
//  ModelFile.swift
//  ForcastWeatherApp
//
//  Created by Hamed Amiry on 18.12.2020.
//

import Foundation

struct WeatherResponse: Codable {
    var latitude: Float?
    var longitude: Float?
    var timezone: String?
   var currently: CurrentlyWeather?
    var hourly: HourlyWeather?
    var daily: DailyWeather?
}

struct CurrentlyWeather: Codable {
    var time: Int?
    var summary: String?
    var icon: String?
    var temperature: Double?
    var apparentTemperature: Double?
    
}



struct HourlyWeather: Codable {
//    var summary: String?
//    var icon: String?
    var data: [HourlyDataWeather]?

}
struct HourlyDataWeather: Codable {
    var time: Int?
    var summary: String?
    var icon: String?
    //var precipType: String?
    var temperature: Double?
}


struct DailyWeather: Codable {
//    var summary: String?
//    var icon: String?
    var data: [DailyDataWeather]?
}
struct DailyDataWeather: Codable {
    var time: Int?
    var summary: String?
    var icon: String?
    var temperatureHigh: Float?
    var temperatureLow: Float?
    
    
}
