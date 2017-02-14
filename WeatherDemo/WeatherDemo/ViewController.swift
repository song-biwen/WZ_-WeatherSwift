//
//  ViewController.swift
//  WeatherDemo
//
//  Created by songbiwen on 2017/2/14.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string:"http://www.weather.com.cn/data/sk/101010100.html");
        
        //配置环境
        let configue = URLSessionConfiguration.default;
        //设置请求超时时间
        configue.timeoutIntervalForRequest = 10;
        
        //建立会话
        let session = URLSession(configuration: configue);
        
        let task = session.dataTask(with: url as! URL) { (data, _, error) in
            if error == nil {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments);
                    
                    let jsonDic = json as! Dictionary<String,Any>
                    let weatherinfo = jsonDic["weatherinfo"] as! Dictionary<String,String>
                    print(weatherinfo);
                    
                    DispatchQueue.main.async {
                        self.cityLabel.text = weatherinfo["city"];
                        self.temLabel.text = weatherinfo["temp"];
                        self.weatherLabel.text = weatherinfo["njd"];
                    }
                    
                }catch {
                    
                }
               
            }
        }
        task.resume();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

