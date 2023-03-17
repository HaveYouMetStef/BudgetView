//
//  QuoteServerModel.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/11/23.
//

import Foundation

///Quote data response
struct QuoteServerModel: Codable {
    let current: Double

    
    enum CodingKeys: String, CodingKey {
        case current = "c"
    }
}
