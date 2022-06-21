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
    let token = "APP_USR-4325235147590421-062109-ed80f12a5f6c2026641253f84e55dbce-245649044"
    
    func get(url: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, headers: headers).response { response in
            completion(response.result)
        }
    }
}
