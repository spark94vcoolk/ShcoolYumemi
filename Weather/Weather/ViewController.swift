//
//  ViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/11.
//

import UIKit


class ViewController: UIViewController {
    
    let yumemitenki = WeatherDetailModel()
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var reloadIndicate: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        reloadIndicate.hidesWhenStopped = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(viewWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        
    }
    
    @objc func viewWillEnterForeground(_ notification: Notification?) {
        if (self.isViewLoaded && (self.view.window != nil)) {
            Task {
                await reloadWeather()
            }
        }
    }
    func reloadWeather() async {
        
        reloadIndicate.startAnimating()
        
        let result = await yumemitenki.setYumemiWether()
        
        self.reloadIndicate.stopAnimating()
        
        switch result {
        case .success(let (weather, max, min)):
            self.complitionWeather(weather: weather, max: max, min: min)
        case .failure(let error):
            self.comlitionWeatherError(alert: "Error: \(error.localizedDescription)")
        }
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
        
    }
    @IBAction func changeWeather(_ sender: Any) {
        Task {
            await reloadWeather()
        }
    }
    
    func comlitionWeatherError(alert: String) {
        let alert = UIAlertController(title: alert, message: "時間をおいてもいう一度お試しください", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    func complitionWeather(weather: String, max: Int, min: Int) {
        
        var imageName = "sunny"
        var tintColor = UIColor.red
        
        switch weather {
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
        self.weatherImage.image = UIImage(named: imageName)
        self.weatherImage.tintColor = tintColor
        self.maxTemperatureLabel.text = String(max)
        self.minTemperatureLabel.text = String(min)
    }
    
}
