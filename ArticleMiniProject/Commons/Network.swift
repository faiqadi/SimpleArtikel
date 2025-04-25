//
//  Network.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 24/04/25.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case serverBusy
    case networkUnavailable
    case unauthorized
    case custom(message: String)
}
protocol NetworkProtocol {
    func request(
        _ url: URLConvertible,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: JSONEncoding,
        timeout: TimeInterval,
        completion: @escaping (Swift.Result<Any, APIError>) -> Void
    )
}
public class Network: NetworkProtocol {
    static let shared = Network()
    private init() {}
    
    func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        encoding: JSONEncoding = JSONEncoding.default,
        timeout: TimeInterval = 120,
        completion: @escaping (Swift.Result<Any, APIError>) -> Void
    ) {
        AF.request(url, method: method, parameters: parameters,
                   encoding: encoding)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    // Handle the raw Data response
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                            completion(.success(json))
                        } else {
                            completion(.failure(.invalidResponse))
                        }
                    } catch {
                        completion(.failure(.invalidResponse))
                    }
                    
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode,
                          500...599 ~= statusCode else {
                        if let urlError = error.underlyingError as? URLError,
                           urlError.code == .notConnectedToInternet || urlError.code == .dataNotAllowed {
                            completion(.failure(.networkUnavailable))
                            return
                        }
                        
                        if let statusCode = response.response?.statusCode,
                           401 == statusCode {
                            completion(.failure(.unauthorized))
                            return
                        }
                        
                        completion(.failure(.custom(message: error.localizedDescription)))
                        return
                    }
                    
                    completion(.failure(.serverBusy))
                }
            }
    }
}
