//
//  ViewController.swift
//  WeatherApp
//
//  Created by Игорь Попов on 23.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onComplition = { [weak self] CurrentWeatherObject in
            guard let self = self else { return }
            self.updateInterface(weather: CurrentWeatherObject)
        }
        networkWeatherManager.fetchCurrentWeather(forCity: "Moscow")
    }
    
    func updateInterface(weather: CurrentWeatherObject) {
        DispatchQueue.main.async {
             self.cityLabel.text = weather.cityName
                   self.temperatureLabel.text = weather.temperatureString
                   self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
                   self.weatherIcon.image = UIImage(systemName: weather.systemIconNameString)
        }
       
    }

}

