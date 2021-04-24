//
//  ViewController.swift
//  WeatherAppSample
//
//  Created by 山田　天星 on 2021/04/24.
//


//iOSアプリ開発デザインパターンよりサンプルテスト
import UIKit

class ViewController: UIViewController {
    
    var label:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label = UITextView()
        label.text = "loading"
        label.frame = CGRect(x:10,y:30,width: self.view.frame.width - 20, height:300)
        self.view.addSubview(label)
        
        let unit = "metric"
        let appId = ""//APIキーを入力してください
        let city = "Tokyo"

        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appId)&units=\(unit)"
        
        let url = URL(string:urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
//  Declaration
//  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
//　第二引数がクロージャの場合は（）外に置くことができる。
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else{return}
            do {
                let object = try JSONSerialization.jsonObject(with: data, options:[]) as? [String:Any]
                print(object)
                DispatchQueue.main.async{
                //UIの変更処理
                    self.label.text = object?.description
                    self.label.sizeToFit()
                }
            } catch let e {
                print(e)
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

