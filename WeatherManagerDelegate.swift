//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Norbert Beckers on 15/05/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func weatherManagerDidUpdateWeather(_ weatherManager: WeatherManager , weather: WeatherModel)
    func weatherManagerDidFailWithError(_ weatherManager: WeatherManager, error: Error)
}
