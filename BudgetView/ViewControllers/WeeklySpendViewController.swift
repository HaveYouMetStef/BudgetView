//
//  WeeklySpendViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 2/25/23.
//

import UIKit
import CoreData

class WeeklySpendViewController: UIViewController {
    
    
    
    //MARK: Outlets
    @IBOutlet weak var weeklyIncomeTextField: UITextField!
    @IBOutlet weak var taxesTextField: UITextField!
    @IBOutlet weak var expensesTextField: UITextField!
    @IBOutlet weak var deductionsTextField: UITextField!
    @IBOutlet weak var weeklySavingsTextField: UITextField!
    @IBOutlet weak var contributionsTextField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    //MARK: Properties
    
    var weeklySpend: WeeklySpend?
    
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.requestBudget()
        if let fetchedWeeklySpend = CoreDataManager.shared.weeklySpend {
            weeklySpend = fetchedWeeklySpend
            updateViews()
        }
        }
    
    
    func calculateWeeklySpend() -> Float {
        var weeklyIncome = Float(weeklyIncomeTextField.text!)
        var taxes = Float(taxesTextField.text!)
        var expenses = Float(expensesTextField.text!)
        var deductions = Float(deductionsTextField.text!)
        var weeklySavings = Float(weeklySavingsTextField.text!)
        var contributions = Float(contributionsTextField.text!)
        
        
        let weeklySpendAmount = weeklyIncome! - taxes! - expenses! - deductions! - weeklySavings! - contributions!
        
        /*See if anything prints to the console
         print(weeklyIncome, taxes, expenses, deductions, weeklySavings, contributions) */
        
        //See if the weekly spend is printed in the console
        print(weeklySpendAmount)
        
        return weeklySpendAmount
        
    }
    
    ///This will present a quick alert controller when the save bar button is tapped
    func presentAlert() {
        
        let saveButtonTapped = UIAlertController(title: "Weekly Spend", message: "Your weekly credentials have been saved!", preferredStyle: .actionSheet)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            print("Okay option selected by user")
        }
        
        [okayAction].forEach{saveButtonTapped.addAction($0)}
        present(saveButtonTapped, animated: true)
    }
    
    
    //MARK: Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        var weeklyIncome = Float(weeklyIncomeTextField.text!)
        var taxes = Float(taxesTextField.text!)
        var expenses = Float(expensesTextField.text!)
        var deductions = Float(deductionsTextField.text!)
        var weeklySavings = Float(weeklySavingsTextField.text!)
        var contributions = Float(contributionsTextField.text!)
        
        print(weeklyIncome, taxes, expenses, deductions,weeklySavings, contributions)
        
        if let weeklySpend = weeklySpend {
            weeklySpend.weeklyIncome = weeklyIncome ?? 0
            weeklySpend.taxes = taxes ?? 0
            weeklySpend.expenses = expenses ?? 0
            weeklySpend.deductions = deductions ?? 0
            weeklySpend.weeklySavings = weeklySavings ?? 0
            weeklySpend.contributions = contributions ?? 0
            
            CoreDataManager.shared.updateBudget(budget: weeklySpend, weeklyIncome: weeklyIncome ?? 0, taxes: taxes ?? 0, expenses: expenses ?? 0, deductions: deductions ?? 0, weeklySavings: weeklySavings ?? 0, contributions: contributions ?? 0)
        } else {
            CoreDataManager.shared.createWeeklySpendBudget(weeklyIncome: weeklyIncome ?? 0, taxes: taxes ?? 0, expenses: expenses ?? 0, deductions: deductions ?? 0, weeklySavings: weeklySavings ?? 0, contributions: contributions ?? 0)
        }
        
        presentAlert()
        CoreDataStack.saveContext()
        
    }
    
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        var weeklySpendBudget = calculateWeeklySpend()
        
        let vc = UIAlertController(title: "Calculated", message: "This is your weekly spending budget! $\(weeklySpendBudget)", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            print("Okay option selected by user on the calculate button")
        }
        
        [okayAction].forEach{vc.addAction($0)}
        
        present(vc, animated: true)
        
        
        
        
    }
    
    //MARK - Functions
    func updateViews() {
        guard let weeklySpend = weeklySpend else { return }
        weeklyIncomeTextField.text = String(weeklySpend.weeklyIncome)
        taxesTextField.text = String(weeklySpend.taxes)
        expensesTextField.text = String(weeklySpend.expenses)
        deductionsTextField.text = String(weeklySpend.deductions)
        weeklySavingsTextField.text = String(weeklySpend.weeklySavings)
        contributionsTextField.text = String(weeklySpend.contributions)
    }
}


