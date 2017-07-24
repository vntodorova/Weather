//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Nemetschek A-Team on 7/19/17.
//  Copyright © 2017 Nemetschek A-Team. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var cityList = ["Sofia", "Berlin", "London", "Madrid", "Boston", "Moscow"]
    var timer : Timer?
    var weatherData: WeatherData?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshData()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(TodayViewController.animateFrame(timer:)), userInfo: nil, repeats: true)
    }
    
    func animateFrame(timer: Timer) {
        refreshData()
    }
    
    func refreshData() {
        let city = cityList[randRange(lower: 0, upper: 5)]
        getWeatherData(for: city, completion: { (error) -> () in
            if error == nil {
                self.updateData()
            }
        })
    }
    
    func updateData() {
        if let unwrappedWD = weatherData {
            self.cityNameLabel.text =  "\(unwrappedWD.cityName!)"
            self.tempLabel.text =  "\(Double(unwrappedWD.temperature!).roundTo(places: 1))º"
            if let url = NSURL(string: "http://openweathermap.org/img/w/\(unwrappedWD.icon!).png") {
                if let data = NSData(contentsOf: url as URL) {
                    self.iconImageView.image = UIImage(data: data as Data as Data)
                }        
            }
            self.descLabel.text =  "\(unwrappedWD.main!)"
            self.humidityLabel.text =  "\(unwrappedWD.humidity!)"
            self.windSpeedLabel.text =  "\(unwrappedWD.windSpeed!)"
        }
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        refreshData()
    }
    
    func getWeatherData(for city: String, completion: @escaping (_ error: NSError?) -> ()) {
        WeatherAPI.getWeather(city: city, completion: { (data, error) -> () in
            DispatchQueue.main.async {
                self.weatherData = data
                completion(error)
            }
        })
    }
    
    func randRange(lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
}


