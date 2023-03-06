//
//  CoreDataManager.swift
//  BudgetView
//
//  Created by Stef Castillo on 2/28/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    var weeklySpend: WeeklySpend?
    
    var income: [Transaction] = []
    
    private lazy var fetchRequest: NSFetchRequest<WeeklySpend> = {
        let request = NSFetchRequest<WeeklySpend>(entityName: "WeeklySpend")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private lazy var fetchIncome: NSFetchRequest<Transaction> = {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //MARK: - CRUD WeeklySpend Functions
    
    func createWeeklySpendBudget(weeklyIncome: Float, taxes: Float, expenses: Float, deductions: Float, weeklySavings: Float, contributions: Float) {
        let weeklyBudget = WeeklySpend(contributions: contributions, deductions: deductions, expenses: expenses, weeklyIncome: weeklyIncome, weeklySavings: weeklySavings)
        weeklySpend = weeklyBudget
        CoreDataStack.saveContext()
    }
    
    func requestBudget() {
        let fetchedBudget = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        if !fetchedBudget.isEmpty {
            weeklySpend = fetchedBudget.first
        }
    }
    
    
    func updateBudget(budget:WeeklySpend,weeklyIncome: Float, taxes: Float, expenses: Float, deductions: Float, weeklySavings: Float, contributions: Float) {
        
        budget.weeklyIncome = weeklyIncome
        budget.taxes = taxes
        budget.expenses = expenses
        budget.deductions = deductions
        budget.weeklySavings = weeklySavings
        budget.contributions = contributions
        
        CoreDataStack.saveContext()
    }
    
    
    func deleteBudget(budget: WeeklySpend) {
        
        if let moc = budget.managedObjectContext {
            moc.delete(budget)
            CoreDataStack.saveContext()
        }
    }
    
    //MARK: - CRUD Income Transaction functions
    func createIncome(amount: Float, date: Date, name: String, type: String) {
        let weeklyIncome = Transaction(amount: amount, date: date, name: name, type: type)
        income.append(weeklyIncome)
        CoreDataStack.saveContext()
    }
    
    func requestIncome() {
        let fetchedIncome = (try? CoreDataStack.context.fetch(fetchIncome)) ?? []
        if !fetchedIncome.isEmpty {
            income = fetchedIncome
        }
    }
    
    func updateIncome(income: Transaction, amount: Float, date: Date, id: String, name: String, type: String) {
        
        income.amount = amount
        income.date = date
        income.id = id
        income.name = name
        income.type = type
        
        CoreDataStack.saveContext()
        
    }
    
    func deleteIncome(income: Transaction) {
        if let moc = income.managedObjectContext {
            moc.delete(income)
            CoreDataStack.context.delete(income)
            CoreDataStack.saveContext()
            requestIncome()
        }
    }
}

