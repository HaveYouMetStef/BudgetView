//
//  QuoteServerModel.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/11/23.
//

import Foundation

///Quote data response
struct QuoteServerModel: Codable {
    let current: [Double]
    let change: [Double]
    let percentChange: [Double]
    let high: [Double]
    let low: [Double]
    let open: [Double]
    let previousClose: [Double]
    let timestamps: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case current = "c"
        case change = "d"
        case percentChange = "dp"
        case high = "h"
        case low = "l"
        case open = "o"
        case previousClose = "pc"
        case timestamps = "t"
    }
}
