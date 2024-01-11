//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/11.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeWeather(_ sender: Any) {
        let weatherResult = YumemiWeather.fetchWeatherCondition()
        switch weatherResult {
        case "sunny":
            self.weatherImage.image = UIImage(named: "sunny")
            self.weatherImage.tintColor = UIColor.red
        case "cloudy":
            self.weatherImage.image = UIImage(named: "cloudy")
            self.weatherImage.tintColor = UIColor.gray
        case "rainy":
            self.weatherImage.image = UIImage(named: "rainy")
            self.weatherImage.tintColor = UIColor.blue
        default:
            break
        }
        
        
    }
    
}
