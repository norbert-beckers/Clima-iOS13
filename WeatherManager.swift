//
//  WeatherManager.swift
//  Clima
//
//  Created by Norbert Beckers on 11/05/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
   let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=96c1ecc7ee924e2ebd25fe96ba668acc&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func getWeather(cityName: String) {
        let urlString = "\(baseUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func getWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlSring = "\(baseUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlSring)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let realError = error {
                    self.delegate?.weatherManagerDidFailWithError(self, error: realError)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.weatherManagerDidUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let weatherModel = WeatherModel(conditionId: decodedData.weather[0].id,
                                            cityName: decodedData.name,
                                            temperature: decodedData.main.temp)
            
            return weatherModel
        } catch {
            delegate?.weatherManagerDidFailWithError(self, error: error)
            return nil
        }
    }
}
