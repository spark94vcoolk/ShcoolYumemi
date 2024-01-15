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
}
//処理を任されるクラス
class YumemiTenki{
    var delegate: YumemiDelegate?

    func setYumemiWether(){
        let weatherResult = YumemiWeather.fetchWeatherCondition()
        delegate?.setWethereImage(type: weatherResult)
        //任せる処理（APIを読み込ませる)を記述
    }
}
