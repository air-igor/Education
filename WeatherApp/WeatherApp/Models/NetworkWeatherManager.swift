//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Игорь Попов on 23.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation

struct NetworkWeatherManager {
    
    var onComplition: ((CurrentWeatherObject) -> Void)?
    
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onComplition?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeatherObject? {
        let decoder = JSONDecoder()
        do {
        let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeatherObject(currentWeatherData: currentWeatherData) else { return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }

}
