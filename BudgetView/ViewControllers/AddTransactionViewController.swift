//
//  AddTransactionViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/2/23.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    //MARK: - Properties
    var isIncomeType = true
    var selectDate = Date() ?? nil
    
    //MARK: - Outlets
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.incomeButton.imageView?.image = UIImage(systemName: "square")
    }
    
    
    //MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameLabel.text,
              let type = isIncomeType ? "Income" : "Expense",
              let date = selectDate,
              let amount = Float(amountLabel.text!) else { return }
        
        CoreDataManager.shared.createIncome(amount: amount, date: date, name: name, type: type)
        CoreDataStack.saveContext()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func incomeCheckBoxButtonTapped(_ sender: Any) {
        
        self.expenseButton.imageView?.image = UIImage(systemName: "square")
        self.incomeButton.imageView?.image = UIImage(systemName: "checkmark.square")
        self.isIncomeType = true
    }
    
    @IBAction func expenseCheckBoxButtonTapped(_ sender: Any) {
        
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
