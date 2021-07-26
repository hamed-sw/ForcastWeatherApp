//
//  WeatherViewModel.swift
//  ForcastWeatherApp
//
//  Created by Hamed Amiry on 18.12.2020.
//

import Foundation
import CoreLocation

protocol searchWeatherDelegate: AnyObject {
    func updateWeather()
}

class WeatherViewModel {
    
    var weather: WeatherResponse?
    weak var delegate: searchWeatherDelegate?
    
    func updateWeatherForLocation (location:String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    JsonParsing.forecast(withLocation: location.coordinate) {  [weak self] weatherss in
                            self?.weather = weatherss
                        self?.delegate?.updateWeather()
          
                    }
                }
            }
        }
    }
    
    func gettimezone() -> String {
        let timeZone = weather?.timezone
        return timeZone ?? ""
    }
    func getCurrentWeatherTime() -> Int {
        let currentTime = weather?.currently?.time
        return currentTime ?? 0
    }
    func getCurrentlySummery() -> String {
        let currentSummery = weather?.currently?.summary
        return currentSummery ?? ""
    }
    func getCurrentIconImage() -> String {
        let currentIconImage = weather?.currently?.icon
        return currentIconImage ?? ""
    }
    func getCurrentTemp() -> Double {
        let currentTemprature = weather?.currently?.temperature
        return currentTemprature ?? 0.0
    }

    func getTotaleNumberOfHourly() -> Int? {
        let totaleHour = weather?.hourly?.data?.count
        return totaleHour ?? 0
    }
    func getDataHourlysummary(at index: Int) -> String? {
        let dataHourlySummary = weather?.hourly?.data?.object(at: index)?.summary
        return dataHourlySummary ?? ""
    }
    func getDataHourlyTime(at index: Int) -> Int? {
        let dataHourlyTime = weather?.hourly?.data?.object(at: index)?.time
        return dataHourlyTime ?? 0
    }

    func getDataHourlyIcon(at index: Int) -> String? {
        let dataHourlyIcon = weather?.hourly?.data?.object(at: index)?.icon
        return dataHourlyIcon ?? ""
    }
    func getDataHourlyTemp(at index: Int) -> Double? {
        let dataHourlyTemp = weather?.hourly?.data?.object(at: index)?.temperature
        return dataHourlyTemp ?? 0.0
    }

    func getTotaleNumberOfDaily() -> Int? {
        let totalDays = weather?.daily?.data?.count
        return totalDays ?? 0
    }
    func getDailyDataSummary(at index: Int) -> String {
        let dailyDataSummary = weather?.daily?.data?.object(at: index)?.summary
        return dailyDataSummary ?? ""
    }
    func getDailyDataTime(at index: Int) -> Int {
        let dailyDataTime = weather?.daily?.data?.object(at: index)?.time
        return dailyDataTime ?? 0
    }
    func getDailyDataIcon(at index: Int) -> String {
        let dailyDataIcon = weather?.daily?.data?.object(at: index)?.icon
        return dailyDataIcon ?? ""
    }
    func getDailyDataLowTemp(at index: Int) -> Float {
        let dailyDataLowTemp = weather?.daily?.data?.object(at: index)?.temperatureLow
        return dailyDataLowTemp ?? 0.0
    }
    func getDailyDAtaHighTemp(at index: Int) -> Float {
        let dailyDataHighTemp = weather?.daily?.data?.object(at: index)?.temperatureHigh
        return dailyDataHighTemp ?? 0.0
    }

}



