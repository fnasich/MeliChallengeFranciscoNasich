//
//  DescriptionModel.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 23/06/2022.
//

import Foundation

struct DescriptionModel: Decodable {
 let code: Int
 let body: BodyDetail
}

struct BodyDetail: Decodable {
  let plain_text: String?
}
