//
//  CollectionViewCell.swift
//  Weather
//
//  Created by spark-02 on 2024/01/31.
//

import UIKit

class CollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var weaterIcon: UICollectionView!
    
    let yumemitenki = WeatherListModel()
    var areas: [weatherListResponce] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weaterIcon.delegate = self
        weaterIcon.dataSource = self
        
        reloadWeather()
    }
    
    func reloadWeather()  {
        Task{
            let result = await yumemitenki.setWeatherList()
            
            switch result {
            case .success(let areas):
                self.areas = areas
                weaterIcon.reloadData()
            case .failure(let error):
                comlitionWeatherError(alert: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "startCollectionViewCell", for: indexPath) as? WeatherCollectionVIewCell else {
            let errorCelll = UICollectionViewCell()
            return errorCelll
        }
        let allWeatherList = areas[indexPath.row]
        
        switch allWeatherList.info.weather_condition {
        case "sunny":
            cell.weatherImageView.image = UIImage(named: "sunny")
            cell.weatherImageView.tintColor = UIColor.red
        case "cloudy":
            cell.weatherImageView.image = UIImage(named: "cloudy")
            cell.weatherImageView.tintColor = UIColor.gray
        case "rainy":
            cell.weatherImageView.image = UIImage(named: "rainy")
            cell.weatherImageView.tintColor = UIColor.blue
        default :
            break
        }
        return cell
    }
    
    func comlitionWeatherError(alert: String) {
        let alert = UIAlertController(title: alert, message: "時間をおいてもいう一度お試しください", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            if let indexPath = weaterIcon.indexPathsForSelectedItems?.first {
                guard let destinaition = segue.destination as? ViewController else {
                    fatalError("Failed to prepare ViewController.")
                }
                destinaition.allArea = areas[indexPath.row]
            }
        }
    }
}
