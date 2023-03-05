//
//  Income+Convenience.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/2/23.
//

import Foundation
import CoreData

extension Transaction {
    
    convenience init(amount: Float, date: Date, name: String, type: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = UUID().uuidString
        self.amount = amount
        self.date = date
        self.name = name
        self.type = type
    }
}
