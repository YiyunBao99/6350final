//
//  ViewController.swift
//  final4
//
//  Created by Yiyun Bao on 12/9/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weatherValue: [WeatherClass] = [WeatherClass]()
    
    var cityNames = ["SEA","SFO", "PDX", "NYC","MIA"]
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getWeather(_ sender: Any) {
        var weathers = ""
        for weather in cityNames {
            weathers.append("\(weather),")
        }
        let weathersStr = weathers.dropLast()
        let url = "\(baseURL)\(weathersStr)"
        print(url)
        SwiftSpinner.show("Getting Weather Values")
        AF.request(url).responseJSON { response in
            SwiftSpinner.hide()
            if response.error != nil {
                print(response.error?.localizedDescription ?? "Error")
                return
            }
            guard let rawData = response.data else {return}
            guard let jsonArray = JSON(rawData).array else {return}
            
            self.weatherValue = [WeatherClass]()
            for weatherJSON in jsonArray {
                print("Weather : \(weatherJSON)")
                let cityCode = weatherJSON["cityCode"].stringValue
                let city = weatherJSON["city"].stringValue
                let temperature = weatherJSON["temperature"].intValue
                let conditions = weatherJSON["cloudy"].stringValue
                
                let weatherClass = WeatherClass()
                weatherClass.cityCode = cityCode
                weatherClass.city = city
                weatherClass.temperature = temperature
                weatherClass.conditions = conditions
                self.weatherValue.append(weatherClass)
            }
            self.tblView.reloadData()
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            weatherValue.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let cityCode = weatherValue[indexPath.row].cityCode
            let city = weatherValue[indexPath.row].city
            let temperature = weatherValue[indexPath.row].temperature
            let conditions = weatherValue[indexPath.row].conditions
            cell.textLabel?.text = "cityCode: \(cityCode) city: \(city) temperature: \(temperature) conditions: \(conditions)"
            return cell
    }
        
}
