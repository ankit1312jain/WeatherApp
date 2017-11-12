//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by BigStep Tech on 12/11/17.
//
//

import UIKit

class WeatherDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var weatherDetailTableview: UITableView!
    var weatherDetailDic = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Detail"

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherDetailTableViewCell
        let tempDic = weatherDetailDic["main"] as! NSDictionary

        if let mintemp = tempDic["temp_min"] as? Double
        {
            cell.minTempValueLabel.text =  "\(mintemp)"
        }
        if let maxtemp = tempDic["temp_max"] as? Double
        {
            cell.maxTempValueLabel.text =  "\(maxtemp)"
        }
        if let humidity = tempDic["humidity"] as? Double
        {
            cell.humidityValueLabel.text =  "\(humidity)"
        }
        
        let weatherArr = weatherDetailDic["weather"] as! NSArray
        if weatherArr.count > 0
        {
          let weatherDic = weatherArr[0] as! NSDictionary
            if let summary = weatherDic["description"] as? String
            {
                cell.summaryValueLabel.text =  "\(summary)"
            }

            
        }
        return cell
    }

}
