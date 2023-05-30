//
//  ExpenseTableViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/8/23.
//

import UIKit


class ExpenseTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var expenseTableView: UITableView!
    @IBOutlet weak var weeklyExpensesButton: UIButton!
    @IBOutlet weak var biweeklyExpensesButton: UIButton!
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataManager.shared.requestExpense()
        
        
        expenseTableView.delegate = self
        expenseTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.requestExpense()
        expenseTableView.reloadData()
    }
    
    //MARK: - Actions
    
    @IBAction func weeklyExpensesButtonTapped(_ sender: Any) {
        let calculateWeeklyExpenses = CoreDataManager.shared.calculateWeeklyExpenses()
        let formatted = String(format: "%.2f", calculateWeeklyExpenses)
        
        let vc = UIAlertController(title: "Calculated", message: "This is your weekly total expenses amount $\(formatted)", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            print("Okay option selected by user on the calculate weekly expenses button")
        }
        
        [okayAction].forEach{vc.addAction($0)}
        
        present(vc, animated: true)
        
    }
    
    @IBAction func biweeklyExpensesButtonTapped(_ sender: Any) {
        let calculateBiweeklyExpenses = CoreDataManager.shared.calculateBiweeklyExpenses()
        let formatted = String(format: "%.2f", calculateBiweeklyExpenses)
        let vc = UIAlertController(title: "Calculated", message: "This is your biweekly total expenses amount $\(formatted)", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            print("Okay option selected by user on the calculate weekly expenses button")
        }
        
        [okayAction].forEach{vc.addAction($0)}
        
        present(vc, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CoreDataManager.shared.expense.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ExpenseTableViewCell
        else { return UITableViewCell()}
        
        let expense = CoreDataManager.shared.expense[indexPath.row]
        
        cell.configure(with: expense)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let expense = CoreDataManager.shared.expense[indexPath.row]
            CoreDataManager.shared.deleteExpense(expense: expense)
            CoreDataManager.shared.requestExpense()
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditExpenseTransaction" {
            guard let indexPath = expenseTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? AddTransactionViewController else { return }
            
            let transactionToSend = CoreDataManager.shared.expense[indexPath.row]
            
            destinationVC.editTransaction = transactionToSend
            destinationVC.isIncomeType = false
        } else if segue.identifier == "toExpenseTransactionVC" {
            guard let destinationVC = segue.destination as? AddTransactionViewController else {
                return
            }

            destinationVC.isIncomeType = false
        }
        
        
    }
    
    
}//End of Class

