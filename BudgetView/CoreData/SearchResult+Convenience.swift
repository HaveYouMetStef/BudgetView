//
//  SearchResult+Convenience.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/16/23.
//

import Foundation
import CoreData

extension SearchResult {
    
    convenience init(companyDescription: String, displaySymbol: String, symbol: String, type: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.companyDescription = companyDescription
        self.displaySymbol = displaySymbol
        self.symbol = symbol
        self.type = type
    }
    
}
