//
//  StartViewService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 16/06/2022.
//

import Foundation

class StartViewService {
    func getCategories(onComplete: @escaping (String) -> Void, onError: @escaping () -> Void) {
        let url = SearchTextManager.shared.searchValue!
        print(url)
        ApiManager.shared.get(url: Constants.categoryPreditorURL + url) {response in
            switch response {
            case .success(let data):
                
                do{
                    
                    if let data = data{
                        let decoder = JSONDecoder()
                        let categoryResponse = try decoder.decode([CategoryPreditor].self, from: data)
//                        print("CATEGORIES: \(categoryResponse[0].category_id)")

                        SearchTextManager.shared.categoryValue = categoryResponse[0].category_id
                        onComplete(categoryResponse[0].category_id)
                    }else{
                        onError()
                    }
                } catch{
                    onError()
                    print(error)
                }
                
            case .failure(_):
                onError()
            }
        }
    }
}
