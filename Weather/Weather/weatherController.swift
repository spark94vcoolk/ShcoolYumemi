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
    func setErrorMessage(error:String)
}


class YumemiTenki{
    var delegate: YumemiDelegate?
    
    func setYumemiWether(){
        do {
            let weatherResult = try YumemiWeather.fetchWeatherCondition(at: "")
            self.delegate?.setWethereImage(type: weatherResult)
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
