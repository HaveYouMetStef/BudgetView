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
    var expense: [Transaction] = []
    var transactionItems: [Transaction] = []
    var stockName: [SearchResult] = []
    var stockPrice: [Quote] = []
    
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
    
    private lazy var fetchExpense: NSFetchRequest<Transaction> = {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private lazy var fetchStockName: NSFetchRequest<SearchResult> = {
        let request = NSFetchRequest<SearchResult>(entityName: "SearchResult")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    private lazy var fetchStockPrice: NSFetchRequest<Quote> = {
        let request = NSFetchRequest<Quote>(entityName: "Quote")
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
        var fetchedIncome = (try? CoreDataStack.context.fetch(fetchIncome)) ?? []
        for income in fetchedIncome {
            print(income.type)
        }
       fetchedIncome = fetchedIncome.filter({$0.type == "Income"})
            income = fetchedIncome
        
//        sectionOffTransactionItems()
    }
    
//    func updateIncome(income: Transaction, amount: Float, date: Date, id: String, name: String, type: String) {
//        
//        income.amount = amount
//        income.date = date
//        income.id = id
//        income.name = name
//        income.type = type
//        
//        CoreDataStack.saveContext()
//        
//    }
    
    func updateIncome(income: Transaction, amount: Float, name: String, type: String, date: Date) {
        
        income.amount = amount
        income.name = name
        income.type = type
        income.date = date
        
        CoreDataStack.saveContext()
        
    }
    
    
    func deleteIncome(income: Transaction) {

            CoreDataStack.context.delete(income)
            CoreDataStack.saveContext()
            requestIncome()
        
    }
    
//    func sectionOffTransactionItems() {
//        for i in transactionItems {
//          if i.type == "Income" {
//                income.append(i)
//            } else if i.type == "Expense" {
//                expense.append(i)
//            }
//        }
//    }
    
    //MARK: - CRUD Expense Transaction Functions
    
    func createExpense(amount: Float, date: Date, name: String, type: String) {
        let monthlyExpense = Transaction(amount: amount, date: date, name: name, type: type)
        expense.append(monthlyExpense)
        CoreDataStack.saveContext()
        
    }
    
    func requestExpense() {
        var fetchedExpense = (try? CoreDataStack.context.fetch(fetchExpense)) ?? []
        for expense in fetchedExpense {
            print(expense.type)
        }
        fetchedExpense = fetchedExpense.filter({$0.type == "Expense"})
            expense = fetchedExpense

    }
    
    func updateExpense(expense: Transaction, amount: Float, date: Date, name: String, type: String) {
        
        expense.amount = amount
        expense.date = date
        expense.name = name
        expense.type = type
        
        CoreDataStack.saveContext()
    }
    
    func deleteExpense(expense: Transaction) {
        if let moc = expense.managedObjectContext {
            moc.delete(expense)
            CoreDataStack.context.delete(expense)
            CoreDataStack.saveContext()
            requestExpense()
        }
    }
    
    func totalIncome() -> Float {
        var total: Float = 0
        for incomeTransaction in income {
            total += incomeTransaction.amount
        }
        return total
    }
    
    func totalMonthlyExpenses() -> Float {
        var total: Float = 0
        for expenseTransaction in expense {
            total += expenseTransaction.amount
        }
        print(total)
        return total
    }
    
    func calculateWeeklyExpenses() -> Float {
        var calculatedWeeklyExpenses = (totalMonthlyExpenses() * 12) / 52
        print(calculatedWeeklyExpenses)
        return calculatedWeeklyExpenses
    }
    
    func calculateBiweeklyExpenses() -> Float {
        var calculatedBiweeklyExpenses = (totalMonthlyExpenses() * 12) / 26
        print(calculatedBiweeklyExpenses)
        return calculatedBiweeklyExpenses
    }
    
    //MARK: CRUD Functions for API calls
    
    func createStockTracker(companyDescription: String, displaySymbol: String, symbol: String, type: String) {
        let stockFinder = SearchResult(companyDescription: companyDescription, displaySymbol: displaySymbol, symbol: symbol, type: type)
        CoreDataStack.saveContext()
    }
    
    func requestStockPrice() {
        
    }
}

