//
//  TopTwentyService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 17/06/2022.
//

import Foundation

class Top20Service {
    func getTopTwenty(categoryId: String,onComplete: @escaping ([String]) -> Void, onError: @escaping () -> Void) {
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
                        var top20: [String] = []
                        categoryResponse.content.map({ top in
                            top20.append(top.id)
                        })
//                        print("TOP 20 SERVICE: \(categoryResponse.content)")
                        onComplete(top20)
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
