//
//  AddTransactionViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/2/23.
//

import UIKit



class AddTransactionViewController: UIViewController {
    
    //MARK: - Properties
    var isIncomeType = false
    var selectDate = Date()
    var incomeItem: Transaction?
    var editTransaction: Transaction?
    var addIncomeTransaction: Transaction?
    var addExpenseTransaction: Transaction?
    
    //MARK: - Outlets
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isIncomeType {
            updateForIncome()
        } else {
            updateForExpense()
        }

        updateView()
        hideKeyboard()
    }
    
  
    //MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameLabel.text,
              let type = isIncomeType ? "Income" : "Expense",
              let amount = Float(amountLabel.text!) else {
            presentAlert()
            return }
        
        print(type)
        
        //update transaction
        if let transaction = editTransaction {
            CoreDataManager.shared.updateIncome(income: transaction, amount: amount, name: name, type: type, date: datePicker.date)
        } else {
            CoreDataManager.shared.createIncome(amount: amount, date: datePicker.date, name: name, type: type)
        }
        
        
        
        self.navigationController?.popViewController(animated: true)
        CoreDataStack.saveContext()
    }
    
    @IBAction func incomeCheckBoxButtonTapped(_ sender: Any) {
        
        updateForIncome()
    }
    
    @IBAction func expenseCheckBoxButtonTapped(_ sender: Any) {
      updateForExpense()
    }
    
    func updateView() {
        guard let transaction = editTransaction else { return }
        nameLabel.text = transaction.name
        if transaction.type == "Income" {
            updateForIncome()
            
        } else {
            updateForExpense()
        }
        amountLabel.text = String(transaction.amount)
        datePicker.date = transaction.date ?? Date()
    }
    
    func updateForIncome() {
        self.expenseButton.setImage(UIImage(systemName: "square"), for: .normal)
        self.incomeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        self.isIncomeType = true
    }
    
    func updateForExpense() {
        self.incomeButton.setImage(UIImage(systemName: "square"), for: .normal)
        self.expenseButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        self.isIncomeType = false
    }
    
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        
        view.endEditing(true)
    }
    
    func presentAlert() {
        
        let wrongCharacterTyped = UIAlertController(title: "Wrong format!", message: "Type in a number", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        
        [okayAction].forEach{wrongCharacterTyped.addAction($0)}
        
        present(wrongCharacterTyped, animated: true)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if isIncomeType {
            updateForIncome()
        } else {
            updateForExpense()
        }

    }
}
