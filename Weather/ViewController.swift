//
//  ViewController.swift
//  Weather
//
//  Created by BigStep Tech on 12/11/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON

var spinner:UIActivityIndicatorView = UIActivityIndicatorView()
class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    var arrRes = [[String:AnyObject]]() //Array of dictionary

    @IBOutlet weak var weatherTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherTable.delegate = self
        weatherTable.dataSource = self
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Weather"
        Getweatherinfo1()
    }
    func Getweatherinfo1() {

        spinner.center = view.center
        spinner.hidesWhenStopped = true
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(spinner)
        spinner.startAnimating()
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?id=4163971&units=metric&APPID=1c5b2a1dcf472971d2dacc9efc2b7cb3").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar.dictionaryObject{
                    self.arrRes.append(resData as [String : AnyObject])
                   
                }
               self.Getweatherinfo2()

            }
        }
    }
    func Getweatherinfo2() {
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?id=2147714&units=metric&APPID=1c5b2a1dcf472971d2dacc9efc2b7cb3").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar.dictionaryObject{
                    self.arrRes.append(resData as [String : AnyObject])
                    
                }
                self.Getweatherinfo3()
                
            }
        }
    }
    func Getweatherinfo3() {
        
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?id=2174003&units=metric&APPID=1c5b2a1dcf472971d2dacc9efc2b7cb3").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                spinner.stopAnimating()
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar.dictionaryObject{
                    self.arrRes.append(resData as [String : AnyObject])
                    print(self.arrRes)
                    self.weatherTable.reloadData()
                }
                
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        var dict = arrRes[indexPath.row]
        cell.cityNameLabel.text = dict["name"] as? String
        let tempDic = dict["main"]
        if let temp = tempDic?["temp"] as? Double
        {
            cell.tempLabel.text =  "\(temp)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        nextVC.weatherDetailDic = arrRes[indexPath.row] as NSDictionary
        self.navigationController?.pushViewController(nextVC, animated: true)
    }


}

