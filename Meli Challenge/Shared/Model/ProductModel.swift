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
    let id, title, thumbnail,  category_id, condition: String
    let price: Float
    let pictures: [Picture]
    let seller_address: SearchLocation
}

struct Picture: Decodable {
    let url: String
}

struct SearchLocation: Decodable {
    let search_location: State
}

struct State: Decodable {
    let state: StateName
}

struct StateName: Decodable {
    let name: String
}

