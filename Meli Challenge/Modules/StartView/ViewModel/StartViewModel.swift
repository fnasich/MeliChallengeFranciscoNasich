//
//  StartViewModel.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 16/06/2022.
//

import Foundation

class StartViewModel {
    private var service: StartViewService
    private var delegate: StartViewDelegate
    private var service2: Top20Service
    private var service3: MultiGetService
    private var top20 = [String]()
    private var products: [MultiGet] = []
    
    init(service: StartViewService, delegate: StartViewDelegate, service2: Top20Service, service3: MultiGetService) {
        self.service = service
        self.delegate = delegate
        self.service2 = service2
        self.service3 = service3
    }
    
    func getCategory() {
        service.getCategories { category in
            let category = category
            SearchTextManager.shared.categoryValue = category
            self.getTop20(categoryId: category)
            self.delegate.loadData()
        } onError: {
            self.delegate.showMessage(message: "Error de búsqueda")
            print("ERROR GETCATEGORY")
        }
        
    }
    
    func getTop20(categoryId: String) {
        service2.getTopTwenty(categoryId: categoryId) { top in
            self.top20 = top
            self.products.removeAll()
            print("ESTE ES TOP: \(top)")
            top.forEach { topId in
                self.getMultiGet(id: topId)
            }
        } onError: {
            self.delegate.showMessage(message: genericError)
            print("ERROR TOP20")
        }
    }
    
    func getMultiGet(id: String) {
        SearchTextManager.shared.multiGetId.append(id)
        self.service3.multiGet(productId: id) { infoId in
            self.products.append(contentsOf: infoId)
            
        } onError: { errorMessage in
            self.delegate.showMessage(message: errorMessage)
            print("ERROR MULTI GET")
        }

    }
    
    func productList(at index: Int) -> MultiGet {
        products[index]
    }
    
    func top20Count() -> Int {
        top20.count
    }
    
}

