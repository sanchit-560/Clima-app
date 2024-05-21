//
//  WeatherModel.swift
//  Clima
//
//  Created by Sanchit Khosla on 24/11/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let conditionID: Int
    let cityName:String
    let temprature:Double
    var StringTemp: String{
        
        return String(format: "%0.1f", temprature)
    }
    var conditionName:String {
        switch conditionID{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 500...531:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
