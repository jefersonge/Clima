//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherViewModel = WeatherViewModel()
    let locationManager = CLLocationManager()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate do textField e weatherManager
        searchTextField.delegate = self
        weatherViewModel.delegate = self
        locationManager.delegate = self
        //permissao para usar localizacao
        locationManager.requestWhenInUseAuthorization()
        //solicitar localizacao
        locationManager.requestLocation()
    }
    
    
        //MARK: - Actions
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    //Botao pesquisar pressionado
    @IBAction func searchPressed(_ sender: Any) {
        //esconder o teclado ao pressionar
        searchTextField.endEditing(true)
    }
    
    //Botao ok do teclado pressionado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //esconder o teclado ao pressionar
        searchTextField.endEditing(true)
        return false
    }
    
    //permitir sair da caixa de texto ao clicar em pesquisar
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Digite primeiro"
            return false
        }
    }
    
    //apos terminar a edicao executar o metodo do json apagar o texto e e
    func textFieldDidEndEditing(_ textField: UITextField) {
        //chamando a funcao da manager
        if let city = searchTextField.text {
            weatherViewModel.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}


//MARK: - WeatherManagerDelegate
extension WeatherViewController : WeatherViewModelDelegate{
    func didUpdateWeather(weather: WeatherModelReponse) {
        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        self.temperatureLabel.text = weather.tempString
        self.cityLabel.text = weather.cityName
    }
}


//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitute = location.coordinate.latitude.description
            let longitude = location.coordinate.longitude.description
            weatherViewModel.fetchWeatherCoord(lat: latitute, lon: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
