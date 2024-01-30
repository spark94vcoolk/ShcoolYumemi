//
//  Area.swift
//  Weather
//
//  Created by spark-02 on 2024/01/29.
//

import Foundation
import YumemiWeather

struct weatherList: Codable {
    var areas: [String]
    var date: String
    
}
struct weatherListResponce: Codable {
    var area: Area
    var info: WeatherResponce
}
