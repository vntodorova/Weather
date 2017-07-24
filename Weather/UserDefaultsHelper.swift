//
//  UserDefaultsHelper.swift
//  Weather
//
//  Created by Nemetschek A-Team on 7/21/17.
//  Copyright © 2017 Nemetschek A-Team. All rights reserved.
//

import UIKit

class UserDefaultsHelper: NSObject {

    private static var CitiesArrayUserDefaults = "Cities"
    
    static func clearUserData() {
        UserDefaults.standard.set(NSArray(), forKey: CitiesArrayUserDefaults)
    }
    
//    static func isAlreadyAdded(searchedCity city : String) -> Bool {
//        let userData = getCurrentUserData()
//        for currentCity in userData {
//            if currentCity.caseInsensitiveCompare(city) == .orderedSame {
//                return true;
//            }
//        }
//        return false;
//    }
    
    static func isAlreadyAdded(_ cityID : Int64) -> Bool {
        let userData = getCurrentUserData()
        for currentID in userData {
            if currentID == cityID {
                return true;
            }
        }
        return false;
    }
    
//    static func saveToUserDefaults(_ city: String) {
//        var newData = Array(getCurrentUserData())
//        newData.append(city)
//        UserDefaults.standard.set(newData, forKey: CitiesArrayUserDefaults)
//    }
    
    static func saveToUserDefaults(_ cityID: Int64) {
        if(!UserDefaultsHelper.isAlreadyAdded(cityID)) {
            var newData = Array(getCurrentUserData())
            newData.append(cityID)
            UserDefaults.standard.set(newData, forKey: CitiesArrayUserDefaults)
        }
    }
    
    static func removeFromUserDefaults(_ cityID: Int64) {
        let currentData = getCurrentUserData()
        let filteredArray = currentData.filter { $0 != cityID }
        UserDefaults.standard.set(filteredArray, forKey: CitiesArrayUserDefaults)
    }
    
    static func getCurrentUserData() -> [Int64] {
        let defaults = UserDefaults.standard
        let currentData = defaults.array(forKey: CitiesArrayUserDefaults) ?? [Int64]()
        return currentData as! [Int64]
    }
    
}
