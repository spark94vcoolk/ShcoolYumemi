//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/11.
//

import UIKit


class ViewController: UIViewController {
    
    let yumemitenki = YumemiTenki()
    
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(viewWillEnterForeground(_:)),
//            name: UIApplication.willEnterForegroundNotification,
//            object: nil)
        yumemitenki.delegate = self
        
    }
    
//    @objc func viewWillEnterForeground(_ notification: Notification?) {
//        if (self.isViewLoaded && (self.view.window != nil)) {
//            yumemitenki.setYumemiWether()
//        }
//    }
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func changeWeather(_ sender: Any) {
        yumemitenki.setYumemiWether()
        
    }
    
}

extension ViewController: YumemiDelegate {
    
    func setMaxTemperature(max: Int) {
        maxTemperatureLabel.text = String(max)
    }
    
    func setMinTemperature(min: Int) {
        minTemperatureLabel.text = String(min)
    }
    
    
    func setErrorMessage(error: String) {
        let alert = UIAlertController(title: error, message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
        
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






