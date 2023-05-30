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
            
            hideKeyboard()
        }
        }
    
    func calculateWeeklySpend(weeklyIncome: Float, taxes: Float, expenses: Float, deductions: Float, weeklySavings: Float, contributions: Float) -> Float {
        
        return weeklyIncome - taxes - expenses - deductions - weeklySavings - contributions

    }
    
    
    // updated function to make sure that the app doesn't crash when you type in a random character or when it is nil
    func calculateWeeklySpendWhenTapped() -> Float {
        guard let weeklyIncome = Float(weeklyIncomeTextField.text ?? ""),
           let taxes = Float(taxesTextField.text ?? ""),
           let expenses = Float(expensesTextField.text ?? ""),
           let deductions = Float(deductionsTextField.text ?? ""),
           let weeklySavings = Float(weeklySavingsTextField.text ?? ""),
           let contributions = Float(contributionsTextField.text ?? ""),
           !weeklyIncome.isNaN,
           !taxes.isNaN,
           !expenses.isNaN,
           !deductions.isNaN,
           !weeklySavings.isNaN,
           !contributions.isNaN else {
            return 0
        }
            
            
            let weeklySpendAmount = calculateWeeklySpend(weeklyIncome: weeklyIncome, taxes: taxes, expenses: expenses, deductions: deductions, weeklySavings: weeklySavings, contributions: contributions)
            

            
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
        var weeklySpendBudget = calculateWeeklySpendWhenTapped()
        
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
    
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        
        view.endEditing(true)
    }
}


