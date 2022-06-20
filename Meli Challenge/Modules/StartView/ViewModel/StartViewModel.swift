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
    private var top20 = [TopTwentyCategory]()
    
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
            print("ESTA ES LA CATEGORIA \(category)")
        } onError: {
            print("Error getCategory")
        }
        
    }
    
    func getTop20(categoryId: String) {
        service2.getTopTwenty(categoryId: categoryId) { top in
            self.top20 = top
            print("ESTE ES TOP: \(top)")
            top.forEach { topId in
                SearchTextManager.shared.multiGetId.append("\(topId.id)")
                self.service3.multiGet(productId: topId) { infoId in
                    print("INFO TOPID: \(infoId)")
                } onError: {
                    print("getMultiGet ERROR")
                }
                
            }
            
            // Agregar llamado de servicio multiGet
            
        } onError: {
            print("getTop20 ERROR")
        }
    }
    
    func productList(at index: Int) -> TopTwentyCategory {
        top20[index]
    }
    
    func top20Count() -> Int {
        top20.count
    }
    
}

