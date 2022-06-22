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
    let token = "APP_USR-4325235147590421-062211-d8d533949b735dcf4713a8a87e7be0d9-245649044"
    
    func get(url: String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, headers: headers).response { response in
            completion(response.result)
        }
    }
}
