//
//  DescriptionService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 23/06/2022.
//

import Foundation
import UIKit

class DescriptionService {
    func getDescription(productId: String,onComplete: @escaping (BodyDetail) -> Void, onError: @escaping (ErrorHandler)) {
        let url = "\(Constants.multigetURL)\(productId)/description"
        ApiManager.shared.get(url: url) {response in
            switch response {
            case .success(let data):
                
                do{
                    
                    if let data = data{
                        let decoder = JSONDecoder()
                        let descriptionResponse = try decoder.decode(DescriptionModel.self, from: data)
                        let productsDescription = descriptionResponse.body
                        print(productsDescription)
                        onComplete(productsDescription)
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
