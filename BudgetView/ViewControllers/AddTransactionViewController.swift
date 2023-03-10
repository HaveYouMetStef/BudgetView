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
    
    //MARK: - Outlets
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.incomeButton.imageView?.image = UIImage(systemName: "square")
        
        updateView()
    }
    
  
    //MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameLabel.text,
              let type = isIncomeType ? "Income" : "Expense",
              let amount = Float(amountLabel.text!) else { return }
        
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
            
        }
        amountLabel.text = String(transaction.amount)
        datePicker.date = transaction.date ?? Date()
    }
    
    func updateForIncome() {
        self.expenseButton.imageView?.image = UIImage(systemName: "square")
        self.incomeButton.imageView?.image = UIImage(systemName: "checkmark.square")
        self.isIncomeType = true
    }
    
    func updateForExpense() {
        self.expenseButton.imageView?.image = UIImage(systemName: "checkmark.square")
        self.incomeButton.imageView?.image = UIImage(systemName: "square")
        self.isIncomeType = false
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toTransactionVC" {
//            guard let indexPath = tableView.indexPathForSelectedRow,
//                  let destinationVC = segue.destination as? IncomeTableViewController else { return }
//        }
//    }
    

}
