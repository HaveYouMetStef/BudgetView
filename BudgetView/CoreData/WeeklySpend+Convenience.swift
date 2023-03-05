//
//  WeeklySpend+Convenience.swift
//  BudgetView
//
//  Created by Stef Castillo on 2/25/23.
//

import Foundation
import CoreData

extension WeeklySpend {
    
    convenience init(contributions: Float, deductions: Float, expenses: Float, weeklyIncome: Float, weeklySavings: Float, context:  NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context:context)
        
        self.contributions = contributions
        self.deductions = deductions
        self.expenses = expenses
        self.weeklyIncome = weeklyIncome
        self.weeklySavings = weeklySavings
        
    }
    
}
