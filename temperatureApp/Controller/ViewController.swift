//
//  ViewController.swift
//  temperatureApp
//
//  Created by Otávio da Silva on 24/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    var temp: Temperature?
    override func viewDidLoad() {
        super.viewDidLoad()
        getTemperature("Porto Alegre")
        
    }
    
    func getTemperature(_ city: String) {
        var city = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\( city)e,br&units=metric&appid=aeefba332b49db396d425480b21571b2")
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("aplication.json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            let task = session.dataTask(with: request) { data, response, error in
                
                if let data = data, error == nil {
                    do {
                        let decoder = JSONDecoder()
                        let temperature = try decoder.decode(Temperature.self, from: data)
                        self.temp = temperature
                        DispatchQueue.main.async {
                            self.temperature.text = String(temperature.main.temp)
                            self.nameCity.text = temperature.name
                        }
                        
                    } catch let error{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }

    @IBAction func searchTap(_ sender: Any) {
        let city = cityTextField.text ?? ""
        temperature.text = String(temp!.main.temp!)
        nameCity.text = temp?.name
        getTemperature(city)
    }
}

