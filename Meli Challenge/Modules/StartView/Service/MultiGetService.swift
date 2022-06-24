//
//  MultiGetService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 17/06/2022.
//

import Foundation

class MultiGetService {
    func multiGet(productId: String,onComplete: @escaping ([MultiGet]) -> Void, onError: @escaping (ErrorHandler)) {
        let stringRepresentation = SearchTextManager.shared.multiGetId.joined(separator: ",")
        let url = Constants.multigetURL + stringRepresentation
        ApiManager.shared.get(url: url) {response in
            switch response {
            case .success(let data):
                do{
                    if let data = data{
                        let decoder = JSONDecoder()
                        let multiGetResponse = try decoder.decode([MultiGetResponse].self, from: data)
                        let productCode = multiGetResponse.filter { $0.code == 200 }
                        let productsData = productCode.map {$0.body}
                        onComplete(productsData)
                    }else{
                        onError(genericError)
                    }
                } catch{
                    onError(genericError)
                    print(error)
                }
                
            case .failure(let error):
                onError(error.errorDescription ?? genericError)
            }
        }
    }
}

let genericError = "Error de búsqueda"
typealias ErrorHandler = (_ errorMessage: String) -> Void
