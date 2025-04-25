//
//  Services.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 24/04/25.
//

import Alamofire
import ObjectMapper

final class NetworkService: NSObject {
    
    static let sharedInstance = NetworkService()
    
    let server: String
    
    override init() {
        server = ApiConfig.instance.mainUrl
        
        super.init()
    }
    
    //Home
    func getArtikel(count: Int, offset: Int = 0, completion: @escaping (Bool, ListArtikelModel?, BaseErrorResponse?, APIError?) -> Void) {
        let url = "\(server)/articles/?limit=\(count)&offset=3"
        
        Network.shared.request(url,
                               method: .get) { (result: Swift.Result<Any, APIError>) in
            switch result {
            case .success(let value):
                guard let response = Mapper<ListArtikelModel>().map(JSONObject: value) else {
                    completion(false, nil, nil, .invalidResponse)
                    return
                }
                completion(true, response, nil, nil)
            case .failure(let failure):
                completion(false, nil, nil, failure)
            }
        }
    }
    func getBlog(count: Int, offset: Int = 0, completion: @escaping (Bool, ListArtikelModel?, BaseErrorResponse?, APIError?) -> Void) {
        let url = "\(server)/blogs/?limit=\(count)&offset=3"
        
        Network.shared.request(url,
                               method: .get) { (result: Swift.Result<Any, APIError>) in
            switch result {
            case .success(let value):
                guard let response = Mapper<ListArtikelModel>().map(JSONObject: value) else {
                    completion(false, nil, nil, .invalidResponse)
                    return
                }
                completion(true, response, nil, nil)
            case .failure(let failure):
                completion(false, nil, nil, failure)
            }
        }
    }
    func getReports(count: Int, offset: Int = 0, completion: @escaping (Bool, ListArtikelModel?, BaseErrorResponse?, APIError?) -> Void) {
        let url = "\(server)/reports/?limit=\(count)&offset=3"
        
        Network.shared.request(url,
                               method: .get) { (result: Swift.Result<Any, APIError>) in
            switch result {
            case .success(let value):
                guard let response = Mapper<ListArtikelModel>().map(JSONObject: value) else {
                    completion(false, nil, nil, .invalidResponse)
                    return
                }
                completion(true, response, nil, nil)
            case .failure(let failure):
                completion(false, nil, nil, failure)
            }
        }
    }
    
    //Search Title Contain
    func getArtikelSearch(title: String, completion: @escaping (Bool, ListArtikelModel?, BaseErrorResponse?, APIError?) -> Void) {
        let url = "\(server)/articles/?title_contains=\(title)"
        
        Network.shared.request(url,
                               method: .get) { (result: Swift.Result<Any, APIError>) in
            switch result {
            case .success(let value):
                guard let response = Mapper<ListArtikelModel>().map(JSONObject: value) else {
                    completion(false, nil, nil, .invalidResponse)
                    return
                }
                completion(true, response, nil, nil)
            case .failure(let failure):
                completion(false, nil, nil, failure)
            }
        }
    }
    func getBlogContain(title: String, completion: @escaping (Bool, ListArtikelModel?, BaseErrorResponse?, APIError?) -> Void) {
        let url = "\(server)/blogs/?title_contains=\(title)"
        
        Network.shared.request(url,
                               method: .get) { (result: Swift.Result<Any, APIError>) in
            switch result {
            case .success(let value):
                guard let response = Mapper<ListArtikelModel>().map(JSONObject: value) else {
                    completion(false, nil, nil, .invalidResponse)
                    return
                }
                completion(true, response, nil, nil)
            case .failure(let failure):
                completion(false, nil, nil, failure)
            }
        }
    }
    func getReportContain(title: String, completion: @escaping (Bool, ListArtikelModel?, BaseErrorResponse?, APIError?) -> Void) {
        let url = "\(server)/reports/?title_contains=\(title)"
        
        Network.shared.request(url,
                               method: .get) { (result: Swift.Result<Any, APIError>) in
            switch result {
            case .success(let value):
                guard let response = Mapper<ListArtikelModel>().map(JSONObject: value) else {
                    completion(false, nil, nil, .invalidResponse)
                    return
                }
                completion(true, response, nil, nil)
            case .failure(let failure):
                completion(false, nil, nil, failure)
            }
        }
    }
}
