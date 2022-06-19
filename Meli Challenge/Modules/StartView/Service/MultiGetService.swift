//
//  MultiGetService.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 17/06/2022.
//

import Foundation

class MultiGetService {
    func multiGet(productId: [Any],onComplete: @escaping (MultiGet) -> Void, onError: @escaping () -> Void) {
        let url = Constants.multigetURL
            print(url)
            ApiManager.shared.get(url: url) {response in
                switch response {
                case .success(let data):
                    
                    do{
                        
                        if let data = data{
                            let str = String(decoding: data, as: UTF8.self)
                                    print(str)
                            let decoder = JSONDecoder()
                            let multiGetResponse = try decoder.decode(MultiGetResponse.self, from: data)
                            print(multiGetResponse.body)
                            onComplete(multiGetResponse.body)
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
