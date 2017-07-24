//
//  ViewController.swift
//  Weather
//
//  Created by Nemetschek A-Team on 7/18/17.
//  Copyright © 2017 Nemetschek A-Team. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    private var weatherDataArray = NSMutableArray()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaultsHelper.clearUserData()
        updateTitleLabel()
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.updateTitleLabel), userInfo: nil, repeats: true)
        loadUserData()
    }
    
    @objc private func updateTitleLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "eee MMM dd yyyy HH:mm"
        titleLabel.text = "\(dateFormatter.string(from: Date()))"
    }
    
    private func getWeatherData(for city:String) {
        WeatherAPI.getWeather(city: city, completion: { (data, error) -> () in
            DispatchQueue.main.async {
                self.addData(data)
            }
        })
    }
    
    private func getWeatherData(for cityID : Int64) {
        WeatherAPI.getWeather(cityID: cityID, completion: { (data, error) -> () in
            DispatchQueue.main.async {
                self.addData(data)
            }
        })
    }
    
    private func loadUserData() {
        let userData = UserDefaultsHelper.getCurrentUserData()
        for cityID in userData {
            DispatchQueue(label: "downloadQueue", attributes: .concurrent).async {
                self.getWeatherData(for: cityID)
            }
        }
    }
    
    private func addData(_ data : WeatherData?) {
        if let unwrappedData = data ,
            let id = unwrappedData.cityID {
            UserDefaultsHelper.saveToUserDefaults(id)
            self.weatherDataArray.add(unwrappedData)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: { alert -> Void in
            if let city = alertController.textFields![0].text {
                let trimmedCity = city.removeSpecialCharsFromString()
                self.getWeatherData(for: trimmedCity)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil)
        
        alertController.addTextField { (textField : UITextField!) -> () in
            textField.placeholder = "Enter city name"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier , for: indexPath) as! CityTableViewCell
        let cellData = self.weatherDataArray.object(at: indexPath.row) as! WeatherData
        cell.setup(with: cellData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if let dataToRemove = weatherDataArray.object(at: indexPath.row) as? WeatherData,
                let cityIDToRemove = dataToRemove.cityID {
                UserDefaultsHelper.removeFromUserDefaults(cityIDToRemove)
            }
            self.weatherDataArray .removeObject(at: indexPath.row)
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" ,
            let nextScene = segue.destination as? DetailsViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedCity = weatherDataArray[indexPath.row]
                nextScene.data = selectedCity as? WeatherData
            }
        }
}
    

