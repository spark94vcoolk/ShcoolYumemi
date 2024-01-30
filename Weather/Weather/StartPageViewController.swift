//
//  StartPageViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/26.
//

import UIKit
import YumemiWeather



class StartPageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var weatherList: UITableView!
    
    let yumemitenki = WeatherListModel()
    var areas: [weatherListResponce] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherList.delegate = self
        weatherList.dataSource = self
        
        reloadWeather()
    }
    
    func reloadWeather()  {
        Task{
            let result = await yumemitenki.setWeatherList()
            
            switch result {
            case .success(let areas):
                self.areas = areas
                weatherList.reloadData()
            case .failure(let error):
                self.comlitionWeatherError(alert: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func comlitionWeatherError(alert: String) {
        let alert = UIAlertController(title: alert, message: "時間をおいてもいう一度お試しください", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        let allWeatherList = areas[indexPath.row]
        cell.textLabel?.text = allWeatherList.area.rawValue
        
        let maxTemperature = allWeatherList.info.max_temperature
        let minTemperature = allWeatherList.info.min_temperature
        cell.detailTextLabel?.text = "最高気温\(maxTemperature)度,最低気温\(minTemperature)度"
        
        switch allWeatherList.info.weather_condition {
        case "sunny":
            cell.imageView?.image = UIImage(named: "sunny")
            cell.imageView?.tintColor = UIColor.red
        case "cloudy":
            cell.imageView?.image = UIImage(named: "cloudy")
            cell.imageView?.tintColor = UIColor.gray
        case "rainy":
            cell.imageView?.image = UIImage(named: "rainy")
            cell.imageView?.tintColor = UIColor.blue
        default :
            break
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail",
           let indexPath = weatherList.indexPathForSelectedRow ,
           let destinaition = segue.destination as? ViewController{
            destinaition.allArea = areas[indexPath.row]
        }
    }
}

