//
//  WeatherData
//  Weather
//
//  Created by Nemetschek A-Team on 7/19/17.
//  Copyright © 2017 Nemetschek A-Team. All rights reserved.
//

import UIKit

class WeatherData : NSObject {
    
    var dataDictionary : NSDictionary = [:]
    var coordDictionary : NSDictionary = [:]
    var weatherDictionary : NSDictionary = [:]
    var mainDictionary : NSDictionary = [:]
    var windDictionary : NSDictionary = [:]
    var cloudsDictionary : NSDictionary = [:]
    var sysDictionary : NSDictionary = [:]
    
    var cityName : String? {
        get { return dataDictionary["name"] as? String }
    }
    var cityID : Int64? {
        get { return dataDictionary["id"] as? Int64 }
    }
    var longtitude : Double? {
        get { return coordDictionary["lon"] as? Double }
    }
    var latitude : Double? {
        get { return coordDictionary["lat"] as? Double }
    }
    var code : Int? {
        get { return weatherDictionary["id"] as? Int }
    }
    var main : String? {
        get { return weatherDictionary["main"] as? String }
    }
    var desc: String? {
        get { return weatherDictionary["description"] as? String }
    }
    var icon : String? {
        get { return weatherDictionary["icon"] as? String }
    }
    var temperature : Double? {
        get { return mainDictionary["temp"] as? Double }
    }
    var pressure : Double? {
        get { return mainDictionary["pressure"] as? Double }
    }
    var humidity : Double? {
        get { return mainDictionary["humidity"] as? Double }
    }
    var tempMin : Double? {
        get { return mainDictionary["temp_min"] as? Double }
    }
    var tempMax : Double? {
        get { return mainDictionary["temp_max"] as? Double }
    }
    var windSpeed : Double? {
        get { return windDictionary["speed"] as? Double }
    }
    var windDegree : Double? {
        get { return windDictionary["deg"] as? Double }
    }
    var clouds : Double? {
        get { return cloudsDictionary["all"] as? Double }
    }
    var country : String? {
        get { return sysDictionary["country"] as? String }
    }

    public init(data: Data) {
        var json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: data)
            if let item = json as? NSDictionary {
               dataDictionary = item
                if let coord = item["coord"] as? NSDictionary {
                    coordDictionary = coord
                }
                if let weather = item["weather"] as? NSArray,
                    let value = weather[0] as? NSDictionary {
                        weatherDictionary = value
                }
                if let main = item["main"] as? NSDictionary {
                    mainDictionary = main
                }
                if let wind = item["wind"] as? NSDictionary {
                    windDictionary = wind
                }
                if let clouds = item["clouds"] as? NSDictionary {
                    cloudsDictionary = clouds
                }
                if let sys = item["sys"] as? NSDictionary {
                    sysDictionary = sys
                }
            }
        } catch {
            print(error)
        }
    }
    
}

