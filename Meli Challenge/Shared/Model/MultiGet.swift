//
//  MultiGet.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 23/06/2022.
//

import Foundation

struct MultiGetResponse: Decodable {
    let code: Int
    let body: MultiGet
}

struct MultiGet: Decodable {
    let id, title, thumbnail,  category_id, condition: String
    let price: Float
    let available_quantity, sold_quantity: Int
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
