//
//  TemperatureBrain.swift
//  temperatureApp
//
//  Created by Otávio da Silva on 30/11/22.
//

import Foundation
protocol TemperatureBrainDelegate {
    func requestSucces(_ temperature: Temperature?)
    func requestError(_ error: Error?)
}
struct TemperatureBrain {
    var delegate: TemperatureBrainDelegate?
    
    func getTemperature(_ city: String) {
        let city = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
        let urlLink: String =  "https://api.openweathermap.org/data/2.5/weather?q=\( city),br&units=metric&appid=aeefba332b49db396d425480b21571b2"
        if let url = URL(string: urlLink) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("deu ruim")
                    self.delegate?.requestError(error)
                    return
                }
                if let data = data {
                    let temperature = self.parseTemperatureJson(data)
                    self.delegate?.requestSucces(temperature)
                }
            }

            task.resume()
            
        }
    }
    

    
    func parseTemperatureJson(_ temperature: Data) -> Temperature? {
        let decoder = JSONDecoder()
        
        do {
            let temperatureDecoder = try decoder.decode(Temperature.self, from: temperature)
            
            return temperatureDecoder
        } catch let error{
            delegate?.requestError(error)
            print(error)
            return nil
        }
        
    }

    
}
