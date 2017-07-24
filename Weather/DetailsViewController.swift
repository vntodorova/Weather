//
//  DetailsViewController.swift
//  Weather
//
//  Created by Nemetschek A-Team on 7/20/17.
//  Copyright © 2017 Nemetschek A-Team. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    public var data : WeatherData?
    
    private var weatherDataElements : NSMutableArray?
    
    private let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cityName = data?.cityName {
            self.cityNameLabel.text = cityName
        }
        setupTableView()
        setupMapView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        parseWeatherDataToDictionary()
    }
    
    func setupMapView() {
        var cityLocation : CLLocation?
        if let lat = data?.latitude ,
            let lon = data?.longtitude {
            cityLocation = CLLocation(latitude: lat, longitude: lon)
            centerMapOnLocation(location: cityLocation!)
        }
    }
    
    func parseWeatherDataToDictionary() {
        if let unwrappedData = data {
            weatherDataElements = NSMutableArray()
            weatherDataElements?.add(("\(unwrappedData.longtitude!)", "Longtitude"))
            weatherDataElements?.add(("\(unwrappedData.latitude!)", "Latitude"))
            weatherDataElements?.add(("\(unwrappedData.desc!)", "\(unwrappedData.main!)"))
            weatherDataElements?.add(("\(unwrappedData.temperature!)", "Temperature"))
            weatherDataElements?.add(("\(unwrappedData.pressure!)", "Pressure"))
            weatherDataElements?.add(("\(unwrappedData.humidity!)", "Humidity"))
            weatherDataElements?.add(("\(unwrappedData.tempMin!)", "Temp MIN"))
            weatherDataElements?.add(("\(unwrappedData.tempMax!)", "Temp MAX"))
            weatherDataElements?.add(("\(unwrappedData.windSpeed!)", "Wind speed"))
            if let unwrappedWindDegree = unwrappedData.windDegree {
                weatherDataElements?.add(("\(unwrappedWindDegree)", "Wind degree"))
            }
            weatherDataElements?.add(("\(unwrappedData.clouds!)", "Clouds"))
            tableView.reloadData()
        }
    }
    
    func setup(_ cell : UITableViewCell, with data : (String, String)) {
        cell.detailTextLabel?.text = data.0
        cell.textLabel?.text = data.1
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataElements!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")
            ?? UITableViewCell(style: .value2, reuseIdentifier: "CellIdentifier")
        
        if let cellData = self.weatherDataElements?.object(at: indexPath.row) as? (String, String) {
            setup(cell, with: cellData)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30;
    }
    
    // MARK: - Map view
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
   
}
