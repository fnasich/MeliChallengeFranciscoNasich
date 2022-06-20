//
//  MultiGetService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 17/06/2022.
//

import Foundation

class MultiGetService {
    func multiGet(productId: TopTwentyCategory,onComplete: @escaping (MultiGet) -> Void, onError: @escaping () -> Void) {
        let stringRepresentation = SearchTextManager.shared.multiGetId.joined(separator: ",")
        let url = Constants.multigetURL + stringRepresentation
            ApiManager.shared.get(url: url) {response in
                switch response {
                case .success(let data):
                    
                    do{
                        
                        if let data = data{
                            let str = String(decoding: data, as: UTF8.self)
                                    print(str)
                            let decoder = JSONDecoder()
                            let multiGetResponse = try decoder.decode([MultiGetResponse].self, from: data)
                            onComplete(multiGetResponse[0].body)
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
