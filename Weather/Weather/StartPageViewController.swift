//
//  StartPageViewController.swift
//  Weather
//
//  Created by spark-02 on 2024/01/26.
//

import UIKit
import YumemiWeather



class StartPageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        return cell
    }
    
    
    @IBOutlet weak var weatherList: UITableView!
    
    let yumemitenki = WeatherListModel()
    var areas: [weatherListResponce] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
