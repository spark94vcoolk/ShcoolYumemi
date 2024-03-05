//
//  weatherController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/12.
//

import UIKit
import YumemiWeather


protocol YumemiDelegate{
    func setWethereImage(type:String)
    func setErrorMessage(error: String)
    func setMaxTemperature(max:Int)
    func setMinTemperature(min:Int)
}

class YumemiTenki{
    var delegate: YumemiDelegate?
    
    func setYumemiWether(){
   
        let requestJson = """
                    {
                        "area": "tokyo", "date": "2020-04-01T12:00:00+09:00"
                    }
                    """
        do {
            let weatherCondition = try YumemiWeather.fetchWeather(requestJson)
            guard let jsonData = weatherCondition.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                  let maxTemperature = json["max_temperature"] as? Int,
                  let minTemperature = json["min_temperature"] as? Int,
                  let weatherConditions = json["weather_condition"] as? String
            else {
                return
            }

            delegate?.setMaxTemperature(max: maxTemperature)
            delegate?.setMinTemperature(min: minTemperature)
            delegate?.setWethereImage(type: weatherConditions)
            
        } catch YumemiWeatherError.unknownError {
            let errorMessage = "エラーが発生しました"
            delegate?.setErrorMessage(error: errorMessage)
        } catch {//自明なことは省略することが多い。catchの後ろになにもなければ
            let errorMessage = "other error occured"
            delegate?.setErrorMessage(error: errorMessage)
        }
        
    }
    
    
}
