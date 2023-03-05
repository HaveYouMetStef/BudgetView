//
//  WeeklySpendController.swift
//  BudgetView
//
//  Created by Stef Castillo on 2/27/23.
//

import Foundation
import CoreData

class WeeklySpendController {
    
    static let shared = WeeklySpendViewController()
    
    func addWeeklySpend(weeklySpend:WeeklySpend) {
        
        saveToPersistentStorage()
    }
    
    
    //MARK: Persistence
    private func saveToPersistentStorage() {
        
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was an error saving to persistent storage: \(error)")
        }
    }
    
    var credentials: [WeeklySpend] {
        let request: NSFetchRequest<WeeklySpend> = WeeklySpend.fetchRequest()
        
        do {
            
            return try CoreDataStack.context.fetch(request)
        } catch {
            print("Error fetching credentials: \(error)")
            return []
        }
    }
}
