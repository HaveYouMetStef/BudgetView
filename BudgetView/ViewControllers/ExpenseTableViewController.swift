//
//  ExpenseTableViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/8/23.
//

import UIKit

//MARK: - Protocols
protocol DeleteExpenseDelegate: AnyObject {
    func deleteExpense(expense: Transaction)
}

class ExpenseTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var expenseTableView: UITableView!
    
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

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
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
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//End of Class

