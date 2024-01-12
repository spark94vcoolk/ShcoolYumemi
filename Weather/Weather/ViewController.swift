//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/11.
//

import UIKit


class ViewController: UIViewController,YumemiDelegate{
    
    
    
    let yumemitenki = YumemiTenki()
    
    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        yumemitenki.delegate = self
        // Do any additional setup after loading the view.
    }
    func setWethereImage() {
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func changeWeather(_ sender: Any) {
        yumemitenki.setYumemiWether()
        
    }
    
    
    func setWethereImage(type:String) {
        
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch type {
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
