//
//  DetailService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 23/06/2022.
//

import Foundation

class DetailService {
    func getDetail(productId: String,onComplete: @escaping ([MultiGet]) -> Void, onError: @escaping (ErrorHandler)) {
        let url = Constants.multigetURL + productId
        ApiManager.shared.get(url: url) {response in
            switch response {
            case .success(let data):
                
                do{
                    
                    if let data = data{
                        let decoder = JSONDecoder()
                        let multiGetResponse = try decoder.decode([MultiGetResponse].self, from: data)
                        let productsData = multiGetResponse.map {$0.body}
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
