//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Jeferson Dias dos Santos on 18/03/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
protocol WeatherViewModelDelegate: AnyObject{
    func didUpdateWeather(weather: WeatherModelReponse)
}
class WeatherViewModel {
    //MARK: - Variables and Constants
    let service = Service.shared
    
    //objeto delegate
    var delegate: WeatherViewModelDelegate?
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=886dbd440c8865caa3faf4dd4d2ab183&units=metric"
    
    //MARK: - Methods
    //buscar clima atraves do nome da cidade - foi chamado la na viewController ao finalizar a busca
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)".lowercased()
        let urlStringReplace = replaceCharacters(inString: urlString)
        guard let url = URL(string: urlStringReplace) else {return}
        //chama o metodo Json
        service.request(url: url) { weather in
            if let weather = weather {
                self.updateInfo(weatherData: weather)
            }
        }
    }
    
    //buscar clima atraves do nome da coordenada - foi chamado la na viewController ao finalizar a busca
    func fetchWeatherCoord(lat: String, lon: String) {
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        guard let url = URL(string: urlString) else {return}
        service.request(url: url) { weather in
            if let weather = weather {
                self.updateInfo(weatherData: weather)
            }
        }
    }
    
    //atualiza informacoes na tela
    func updateInfo(weatherData: WeatherData){
        let id = weatherData.weather?[0].id ?? 0
        let temp = weatherData.main?.temp ?? 0
        let name = weatherData.name ?? "Nome invalido"
        //instanciar a classe model e seu construtor
        let weather = WeatherModelReponse(conditionId: id, cityName: name, temperature: temp)
        delegate?.didUpdateWeather(weather: weather)
    }
    
    //remove espaços E acentos dos nomes das cidades para buscar na api
    func replaceCharacters (inString: String) -> String {
        inString.replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: "á", with: "a")
            .replacingOccurrences(of: "ã", with: "a")
            .replacingOccurrences(of: "â", with: "a")
    }
}
