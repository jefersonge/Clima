//
//  WeatherData.swift
//  Clima
//
//  Created by Jeferson Dias dos Santos on 28/12/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//


//https://api.openweathermap.org/data/2.5/weather?q=Araguari&appid=886dbd440c8865caa3faf4dd4d2ab183&units=metric
//MODELO DE COMO É O JSON LA NA API


import Foundation

struct WeatherData: Decodable {
    let name: String?
    let main: Main?
    let weather: [Weather]?
}

struct Main: Decodable {
    let temp : Double?
    let humidity: Int?
}

struct Weather: Decodable {
    let id : Int?
}
