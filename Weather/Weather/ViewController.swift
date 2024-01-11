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
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch weatherResult{
        case "sunny":
            imageName = "sunny"
            tintColor = UIColor.red
        case "cloudy":
            imageName = "cloudy"
            tintColor = UIColor.gray
        case "rainy":
            imageName = "rainy"
            tintColor = UIColor.blue
        default:
            break
        }
        
        weatherImage.image = UIImage(named: imageName)
        weatherImage.tintColor = tintColor
        
        
        
        
    }
    
}
