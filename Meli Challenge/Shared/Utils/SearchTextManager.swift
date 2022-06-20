//
//  SearchTextManager.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 16/06/2022.
//

import Foundation

class SearchTextManager {
    static let shared = SearchTextManager()
    
    var searchValue: String?
    var categoryValue: String?
    var multiGetId: [String] = []
    
    init(){}
}
