//
//  weatherController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/12.
//
import UIKit
import YumemiWeather

struct weatherData: Codable {
    var area: String
    var date: String
}
struct WeatherResponce: Codable {
    let weather_condition:String
    let max_temperature: Int
    let min_temperature: Int
}

class YumemiTenki{
    
    func setYumemiWether() async -> Result<(String,Int,Int), Error > {
        let tokyoData = weatherData(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
        do {
            let encoder = JSONEncoder()
            let JsonTokyoData = try encoder.encode(tokyoData)
            guard let tokyoDataJsonString = String(data: JsonTokyoData, encoding: .utf8) else {
                return (.failure(YumemiWeatherError.unknownError))
                
            }
            
            let weatherCondition = try await YumemiWeather.asyncFetchWeather(tokyoDataJsonString)
            
            guard let jsonData = weatherCondition.data(using: .utf8) else {
                return(.failure(YumemiWeatherError.unknownError))
                
            }
            let decoder = JSONDecoder()
            let responce = try decoder.decode(WeatherResponce.self,from: jsonData)
            
            
            return(.success((responce.weather_condition, responce.max_temperature, responce.min_temperature)))
        } catch {
            return(.failure(error))
            
        }
    }
}



