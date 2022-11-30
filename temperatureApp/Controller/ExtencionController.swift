//
//  ExtencionController.swift
//  temperatureApp
//
//  Created by Otávio da Silva on 30/11/22.
//

import UIKit

extension TemperatureViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        showLoader()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Digite uma cidade valida"
            hideLoader()
            return false
        } else {
            return true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let city = textField.text ?? ""
        temperatureBrain.getTemperature(city)
        showLoader()
        textField.text = ""
        
    }

    
}
extension TemperatureViewController: TemperatureBrainDelegate {
    func requestSucces(_ temperature: Temperature?) {
        DispatchQueue.main.async {
            self.hideLoader()
            let convert = Int(temperature?.main.temp ?? 0)
            self.temperature.text = String(convert)
            self.nameCity.text = temperature?.name
        }
    }
    func requestError(_ error: Error?) {
        DispatchQueue.main.async {
            self.hideLoader()
            let errorMenssager = UIAlertController(title: "Atenção", message: "Algo deu errado tente novamente mais tarde.", preferredStyle: .alert)
            errorMenssager.addAction(UIAlertAction(title: "fechar", style: .cancel))
            self.present(errorMenssager, animated: true)
        }

    }
    
    
    
}
