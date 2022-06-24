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
    let token = "APP_USR-4325235147590421-062400-f0df0d633094198c4165a290887d9328-245649044"
    
    func get(url: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, headers: headers).response { response in
            completion(response.result)
        }
    }
}
