//
//  TopTwentyCategory.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 23/06/2022.
//

import Foundation

struct TopTwentyCategory: Decodable {
    let id: String
}

struct TopTwentyResponse: Decodable {
    let content: [TopTwentyCategory]
}
