//
//  ProductModel.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 16/06/2022.
//

import Foundation


struct CategoryPreditor: Decodable {
    let category_id: String
}

struct TopTwentyResponse: Decodable {
    let content: [TopTwentyCategory]
}

struct TopTwentyCategory: Decodable {
    let id: String
}

struct MultiGetResponse: Decodable {
    let body: MultiGet
}

struct MultiGet: Decodable {
  let id, title, category_id: String
  let price: Int
}
