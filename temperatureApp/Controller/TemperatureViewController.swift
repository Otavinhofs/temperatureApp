//
//  ViewController.swift
//  temperatureApp
//
//  Created by Otávio da Silva on 24/11/22.
//

import UIKit

class TemperatureViewController: UIViewController {

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var cityTextField: UITextField!
    var temp: Temperature?
    var temperatureBrain = TemperatureBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        temperatureBrain.delegate = self
        temperatureBrain.getTemperature("Porto Alegre")
        self.cityTextField.delegate = self
        
    }
    
    @IBAction func searchTap(_ sender: Any) {
        let city = cityTextField.text ?? ""
        temperatureBrain.getTemperature(city)
        textFieldDidEndEditing(cityTextField)
    }
    
    func showLoader() {
        self.loaderView.isHidden = false
        self.loader.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func hideLoader() {
        self.loaderView.isHidden = true
        self.loader.startAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
}

