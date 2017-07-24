//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Nemetschek A-Team on 7/21/17.
//  Copyright © 2017 Nemetschek A-Team. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CityTableViewCell"
    
    var cellImageView : UIImageView = UIImageView()
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    func setup(with data:WeatherData) {
        self.cityLabel.text = "\(data.cityName!) (\(data.country!))"
        self.temperatureLabel.text = "\(Double(data.temperature!).roundTo(places: 1))º"
        self.windSpeedLabel.text = "\(data.windSpeed!)"
        self.humidityLabel.text = "\(data.humidity!)"
        
        cellImageView = UIImageView(frame: self.bounds);
        cellImageView.image = backgroundImage(for: data.code)
        self.addSubview(cellImageView)
        cellImageView.autoresizingMask = .flexibleWidth
        self.sendSubview(toBack: cellImageView)
    }
    
    func backgroundImage(for code: Int?) -> UIImage? {
        var image = UIImage()
        if let unwrappedCode = code {
            switch unwrappedCode {
            case 800:
                image = UIImage(named: "sunny.png")!;
            case 500, 501, 502, 503, 504, 511, 520, 521, 522, 531:
                image = UIImage(named: "rainy.png")!;
            default:
                image = UIImage(named: "cloudy.png")!;
            }
        }
        return image
    }

}
