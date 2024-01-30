//
//  WeatherListMode.swift
//  Weather
//
//  Created by spark-02 on 2024/01/29.
//

import Foundation
import YumemiWeather


class WeatherListModel {
    
    func setWeatherList() async -> Result<WeatherResponce, Error > {
        let date = Date().ISO8601Format() //現在の日本の時刻
        let weatherAreaList = weatherList(areas: [], date: date)
        do {
            let weatherListEncoder = JSONEncoder()
            let JsonAreasData = try weatherListEncoder.encode(weatherAreaList)
            guard let areasDataJsonString = String(data: JsonAreasData, encoding: .utf8) else {
                return .failure(YumemiWeatherError.unknownError)
                
            }
            
            let weatherInfo = try await YumemiWeather.asyncFetchWeatherList(areasDataJsonString)
            
            guard let ListjsonData = weatherInfo.data(using: .utf8) else {
                return .failure(YumemiWeatherError.unknownError)
                
            }
            let weatherListDecoder = JSONDecoder()
            let responce = try weatherListDecoder.decode([weatherListResponce].self,from: ListjsonData)
            
            return .success(responce)
        } catch {
            return .failure(error)
            
        }
    }
}


