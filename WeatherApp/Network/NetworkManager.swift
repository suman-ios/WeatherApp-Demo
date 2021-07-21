//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Dev on 2021-07-19.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case unprocessableEntity(String?)
    case internetConnectionError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .internetConnectionError:
            return Message.noInterNet.localized
        case .unprocessableEntity(let errorString):
            return errorString
        }
    }
}

class NetworkManager {
    public static func makeRequest<T: Codable>(_ urlRequest: URLRequestConvertible, mode: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let request = AF.request(urlRequest).validate().responseString { response in
            switch response.result {
            case .success(let jsonString):
                let jsonData: Data = jsonString.data(using: .utf8)!
                #if DEBUG
                debugPrint("\nResponse: ")
                debugPrint(jsonString)
                #endif
                let decoder = JSONDecoder()
                do {
                    let weather = try decoder.decode(T.self, from: jsonData)
                    completion(.success(weather))
                } catch {
                    completion(.failure(.unprocessableEntity(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(.unprocessableEntity(error.localizedDescription)))
            }
        }
        #if DEBUG
        debugPrint("\nRequest: ")
        debugPrint(request.cURLDescription())
        #endif
    }
}

func jsonToNSData(json: [String: Any]) -> Data? {
    do {
        return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
    } catch let myJSONError {
        print(myJSONError)
    }
    return nil;
}

