//
//  WeatherData.swift
//  Clima
//
//  Created by Norbert Beckers on 12/05/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: MainData
    let weather: [WeatherItem]
}
