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
        
                        guard let categoryTemp = categoryResponse[0].category_id else {
                            preconditionFailure("Error")
                        }
                        
                        SearchTextManager.shared.categoryValue = categoryTemp
                        onComplete(categoryTemp)
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
