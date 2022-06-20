//
//  TopTwentyService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 17/06/2022.
//

import Foundation

class Top20Service {
    func getTopTwenty(categoryId: String,onComplete: @escaping ([TopTwentyCategory]) -> Void, onError: @escaping () -> Void) {
        let url = Constants.topTwentyURL + categoryId
        print(url)
        ApiManager.shared.get(url: url) {response in
            switch response {
            case .success(let data):
                
                do{
                    
                    if let data = data{
                        let str = String(decoding: data, as: UTF8.self)
                                print(str)
                        let decoder = JSONDecoder()
                        let categoryResponse = try decoder.decode(TopTwentyResponse.self, from: data)
//                        print("TOP 20 SERVICE: \(categoryResponse.content)")
                        onComplete(categoryResponse.content)
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
