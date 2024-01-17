//
//  weatherController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/12.
//

import UIKit
import YumemiWeather

struct weatherData:Codable {
    var area: String
    var data: String
}


protocol YumemiDelegate{
    func setWethereImage(type:String)
    func setErrorMessage(error: String)
    func setMaxTemperature(max:Int)
    func setMinTemperature(min:Int)
}


class YumemiTenki{
    var delegate: YumemiDelegate?
    let tokyoData = weatherData(area: "tokyo", data: "2020-04-01T12:00:00+09:00")
    
    func setYumemiWether(){
        
        //        let requestJson = """
        //                            {
        //                                "area": "tokyo", "date": "2020-04-01T12:00:00+09:00"
        //                            }
        //                            """
        do {
            let encoder = JSONEncoder()
            let JsonTokyoData = try encoder.encode(tokyoData)//tryに！をつけなくてよくするためにguard let をつかってエラーの場合も記述してあげる。
            //let JsonData = try JSONEncoder().encode(requestJson)  と1行にしても良い
            guard let tokyoDataJsonString = String(data: JsonTokyoData, encoding: .utf8)
            else {
                return
            }
            
            let weatherCondition = try YumemiWeather.fetchWeather(tokyoDataJsonString)
            
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
            
            //            print(requestJson)
            //            print(minTemperature)
            //            print(weatherConditions)
            
        } catch YumemiWeatherError.unknownError {
            let errorMessage = "エラーが発生しました"
            delegate?.setErrorMessage(error: errorMessage)
        } catch {//自明なことは省略することが多い。catchの後ろになにもなければ
            let errorMessage = "other error occured"
            delegate?.setErrorMessage(error: errorMessage)
        }
        
    }
    
    
}

//alertメッセージをDelegateでViewControllerに渡す
//　ViewControllreでダイヤルボックスを表示させる
