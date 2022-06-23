//
//  DetailViewModel.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 23/06/2022.
//

import Foundation

class DetailViewModel {
    private let service: DetailService
    private var productId: String
    private let delegate: DetailDelegate?
    
    init(service: DetailService, productId: String, delegate: DetailDelegate) {
        self.service = service
        self.productId = productId
        self.delegate = delegate
    }
    
    func getDetails() {
        service.getDetail(productId: productId) { product in
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.loadProductData(product: product[0])
                self?.delegate?.spinnerLoadingState(state: false)
            }
        } onError: { errorMessage in
            print(errorMessage)
        }
    }
}
