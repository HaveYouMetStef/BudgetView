//
//  SearchServerModel.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/11/23.
//

import Foundation

///API response for search
struct SearchResponse: Codable {
    let count: Int
    let result: [SearchServerModel]
}


struct SearchServerModel: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type: String
}
