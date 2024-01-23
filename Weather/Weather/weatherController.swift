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
//protocol YumemiDelegate{
//    func setWethereImage(type:String)
//    func setErrorMessage(error: String)
//    func setMaxTemperature(max:Int)
//    func setMinTemperature(min:Int)
//}

class YumemiTenki{
    
   // var delegate: YumemiDelegate?
    
    let tokyoData = weatherData(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
    
    func setYumemiWether(){
        DispatchQueue.global().async {
            
            do {
                let encoder = JSONEncoder()
                let JsonTokyoData = try encoder.encode(self.tokyoData)
                guard let tokyoDataJsonString = String(data: JsonTokyoData, encoding: .utf8)
                else {
                    return
                }
                
                let weatherCondition = try YumemiWeather.syncFetchWeather(tokyoDataJsonString)
                guard let jsonData = weatherCondition.data(using: .utf8),
                      let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                      
                else {
                    return
                }
                
//                self.delegate?.setMaxTemperature(max: maxTemperature)
//                self.delegate?.setMinTemperature(min: minTemperature)
//                self.delegate?.setWethereImage(type: weatherConditions)
                
            } catch YumemiWeatherError.unknownError {
                let errorMessage = "unknownエラーが発生しました"
                //self.delegate?.setErrorMessage(error: errorMessage)
            } catch YumemiWeatherError.invalidParameterError {
                let errorMessage = "invalidエラーが発生しました"
                //self.delegate?.setErrorMessage(error: errorMessage)
            } catch {
                let errorMessage = "other error occured"
                //self.delegate?.setErrorMessage(error: errorMessage)
            }
        }
    }
}

