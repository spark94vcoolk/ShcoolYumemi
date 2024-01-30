//
//  Weather.swift
//  Weather
//
//  Created by spark-02 on 2024/01/29.
//

import Foundation

struct weatherData: Codable {
    var area: String
    var date: String
}
struct WeatherResponce: Codable {
    let weather_condition:String
    let max_temperature: Int
    let min_temperature: Int
}
