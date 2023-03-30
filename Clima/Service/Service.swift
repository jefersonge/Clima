//
//  WeatherManager.swift
//  Clima
//
//  Created by Jeferson Dias dos Santos on 28/12/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//


//TODA A LOGICA DA API - TASK
import Foundation


struct Service {
    
    static let shared = Service()
    func request(url: URL, completion: @escaping (WeatherData?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {return}
            do {
                let wheater = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    completion(wheater)
                }
            } catch  {
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
}
