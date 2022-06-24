//
//  SearchTextManager.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 16/06/2022.
//

import Foundation

class SearchTextManager {
    static let shared = SearchTextManager()
    //MARK: Search Value
    // Text type by user in search bar
    var searchValue: String?
    //MARK: Category Value
    var categoryValue: String?
    //MARK: Multi Get Ids
    var multiGetId: [String] = []
    
    init(){}
}
