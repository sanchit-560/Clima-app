//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatWeather(_ weatherManager:WeatherManager, weather:WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.StringTemp
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        searchTextField.delegate = self
        weatherManager.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchPressed(_ sender: UIButton) {
       searchTextField.endEditing(true)
//       cityLabel.text = searchTextField.text!
       print(searchTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print(searchTextField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true
        }
        else{
            textField.placeholder = "Please Type a City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
         weatherManager.fetchWeatherUrl(cityName: city)
            cityLabel.text = city
        }
        searchTextField.text = " "
//        print(city!)
    }
    
    
    
}

