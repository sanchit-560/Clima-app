//
//  WeatherManager.swift
//  Clima
//
//  Created by Sanchit Khosla on 24/11/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
protocol  WeatherManagerDelegate {
    func didUpdatWeather(_ weatherManager:WeatherManager, weather:WeatherModel)
    func didFailWithError(error:Error)
}
struct WeatherManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=a039ebac37b3cb0b88ef54e667548d11&units=metric"
    func fetchWeatherUrl(cityName:String){
       let urlString = url+"&q="+cityName
       performRequest(urlString)
//       print(urlString)
    }
  
    var delegate: WeatherManagerDelegate?
    
    func performRequest(_ urlString: String){
        //1. Create a URl session
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error  in
                if error != nil {
                    delegate?.didFailWithError(error:error!)
                    print(error!)
                    return
                }
                
                if let safeData = data{
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    if let weather = parseJson(safeData){
                        delegate?.didUpdatWeather(self, weather:weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ weatherData:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
          let decodedData =  try  decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
//            print(decodedData.weather[0].description)
            let id=decodedData.weather[0].id
            let weather = WeatherModel(conditionID: id, cityName: name, temprature: temp)
//            print(weather.conditionName)
//            (print(weather.StringTemp))
            return weather
        }
        catch{
            delegate?.didFailWithError(error:error)
            return nil
        }
        
    }
    
    
    

}
