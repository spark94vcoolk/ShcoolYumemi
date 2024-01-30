//
//  weatherController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/12.
//
import UIKit
import YumemiWeather


class WeatherDetailModel{
    
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



