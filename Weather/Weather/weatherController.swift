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
struct wetheherRespnce: Codable {
    let weather_condition:String
    let max_temperature: Int
    let min_temperature: Int
}

class YumemiTenki{
    
    func setYumemiWether(completion: @escaping (Result<(String,Int,Int), Error >) -> Void ) {
        DispatchQueue.global().async {
            let tokyoData = weatherData(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
            do {
                let encoder = JSONEncoder()
                let JsonTokyoData = try encoder.encode(tokyoData)
                guard let tokyoDataJsonString = String(data: JsonTokyoData, encoding: .utf8) else {
                    completion(.failure(YumemiWeatherError.unknownError))
                    return
                }
                
                let weatherCondition = try YumemiWeather.syncFetchWeather(tokyoDataJsonString)
                
                guard let jsonData = weatherCondition.data(using: .utf8) else {
                    completion(.failure(YumemiWeatherError.unknownError))
                    return
                }
                
                let decoder = JSONDecoder()
                let wetheherRespnce = try decoder.decode(wetheherRespnce.self,from: JsonTokyoData)
                
                DispatchQueue.main.async {
                    completion(.success((weatherResponse.weather_condition, weatherResponse.max_temperature, weatherResponse.min_temperature)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
