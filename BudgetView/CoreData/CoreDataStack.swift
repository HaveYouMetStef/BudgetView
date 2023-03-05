//
//  CoreDataStack.swift
//  BudgetView
//
//  Created by Stef Castillo on 2/25/23.
//

import CoreData
import Foundation

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BudgetView")
        container.loadPersistentStores() { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Error loading persistent stores \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext}
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                NSLog("Error saving context \(error)")
            }
        }
    }
}
