//
//  WeatherAppManager.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation
typealias CompletionBlock = (_ success: Bool, _ response: Any?) -> Void
class WeatherAppManager {
    static let shared: WeatherAppManager = WeatherAppManager()
    func getWeatherData(cityName: String, completion: @escaping(CompletionBlock)) {
        let weatherRequest = WeatherHttpRouter.getWeatherData(days: 4, cityName: cityName)
        NetworkManager.makeRequest(weatherRequest, mode: WeatherModel.self) { (result) in
            switch result {
            case .success(let weatherData):
                completion(true, weatherData)
            case .failure(let errorMessage):
                completion(false, errorMessage)
            }
        }
    }
}
