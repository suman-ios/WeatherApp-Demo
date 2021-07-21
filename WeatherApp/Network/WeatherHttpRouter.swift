//
//  WeatherHttpRouter.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation
import Alamofire
public enum WeatherHttpRouter: URLRequestConvertible {
    case getWeatherData(days: Int, cityName: String)
    
    var method: String {
        switch self {
        case .getWeatherData:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .getWeatherData:
            return ""
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
        case .getWeatherData(let days, let cityName):
            return ["q": cityName, "days": days, "key": Configuration.apiKey, "aqi": "no", "alerts": "no"]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: Configuration.baseURL + self.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.timeoutInterval = 60
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        switch self {
        case .getWeatherData:
            return try URLEncoding.queryString.encode(urlRequest, with: self.urlParameters)
        }
    }
}
