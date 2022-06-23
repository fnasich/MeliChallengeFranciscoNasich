//
//  ApiManager.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 16/06/2022.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    let token = "APP_USR-4325235147590421-062308-6b8b01893bd8d172bdff1f5a993fb4a1-245649044"
    
    func get(url: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, headers: headers).response { response in
            completion(response.result)
        }
    }
}
