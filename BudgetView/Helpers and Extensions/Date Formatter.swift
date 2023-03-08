//
//  Date Formatter.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/5/23.
//

import Foundation

extension DateFormatter {
    static let transactionDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        return dateFormatter
    }()
} // End of extension
