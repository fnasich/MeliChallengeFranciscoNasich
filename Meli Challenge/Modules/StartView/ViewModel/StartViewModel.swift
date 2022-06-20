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
    var top20 = [TopTwentyCategory]()
    
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
            print(category)
        } onError: {
            print("Error getCategory")
        }
        
    }
    
    func getTop20(categoryId: String) {
        service2.getTopTwenty(categoryId: categoryId) { top in
            let top = top
            self.top20 = top
            print("ESTE ES EL TOP 20 \(top)")
            // Agregar llamado de servicio multiGet
            self.multiGet(productId: top)
        } onError: {
            print("getTop20 ERROR")
        }
    }
    
    func multiGet(productId: [Any]) {
        service3.multiGet(productId: productId) { MultiGet in
            let multiget = MultiGet
            print(multiget)
        } onError: {
            print("multiGet error")
        }

    }
    
    func top20List(at index: Int) -> TopTwentyCategory {
        top20[index]
    }
    
    func top20Count() -> Int {
        top20.count
    }
}

