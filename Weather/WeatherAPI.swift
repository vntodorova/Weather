//
//  WeatherAPI.swift
//  Weather
//
//  Created by Nemetschek A-Team on 7/18/17.
//  Copyright © 2017 Nemetschek A-Team. All rights reserved.
//

import UIKit

class WeatherAPI {
    
    typealias WeatherDataCompletionBlock = (_ data: WeatherData?, _ error: NSError?) -> ()

    private static let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private static let openWeatherMapAPIKey = "e9a1658cdd2c1971f6ae6521334d4277"
    
    static func getWeather(city: String, completion: @escaping WeatherDataCompletionBlock) {
        let session = URLSession.shared
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)&units=metric")!
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                 completion(nil, error as NSError?)
            }
            else {
                let data = WeatherData(data: data!)
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
    
    static func getWeather(cityID: Int64, completion: @escaping WeatherDataCompletionBlock) {
        let session = URLSession.shared
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&id=\(cityID)&units=metric")!
        let dataTask = session.dataTask(with: weatherRequestURL as URL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(nil, error as NSError?)
            }
            else {
                let data = WeatherData(data: data!)
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
    
}
