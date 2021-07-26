//
//  JsonHourly.swift
//  ForcastWeatherApp
//
//  Created by Hamed Amiry on 21.12.2020.
//

import Foundation
import CoreLocation

class HourlyJson {
    //typealias success = (WeatherResponse) -> ()
    
   // static let urlPath = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/"
    typealias success = (WeatherResponse) ->()
    
    static func  forecast (withLocation location: CLLocationCoordinate2D, onSuccess: @escaping success) {
        let latitude = location.latitude
        //print(latitude)
        let longitude = location.longitude

        if let  url = URL(string: ("https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(latitude),\(longitude)") ) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                do{
                    let json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    onSuccess(json)
                }catch {
                    print("there is error.......")
                    
                }
            }.resume()
         }
       }
}
