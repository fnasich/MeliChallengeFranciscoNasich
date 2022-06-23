//
//  DescriptionViewModel.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 23/06/2022.
//

import Foundation

class DescriptionViewModel {
    private var service: DescriptionService
    private var productId: String
    private var description: String = ""
    
    init(service: DescriptionService, productId: String) {
        self.service = service
        self.productId = productId
    }
    
    func getDescription(){
        service.getDescription(productId: productId) { detail in
            let d = detail.plain_text
            print(d)
            self.description = d!
        } onError: { errorMessage in
            print("error description: \(errorMessage)")
        }
    }
    
    func showDecription() -> String {
        return description
    }
}
