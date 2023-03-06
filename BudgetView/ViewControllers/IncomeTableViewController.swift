//
//  IncomeTableViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/2/23.
//

import UIKit

class IncomeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //MARK: - Outlets
    @IBOutlet weak var incomeTableView: UITableView!
    
    //MARK: - properties
    var deposits: [Transaction] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.requestIncome()
        if !CoreDataManager.shared.income.isEmpty {
            deposits = CoreDataManager.shared.income
        }
        incomeTableView.delegate = self
        incomeTableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        incomeTableView.reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        incomeTableView.reloadData()
//    }

    // MARK: - Table view data source

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deposits.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as? IncomeTableViewCell
        else { return UITableViewCell()}
        
        let deposit = CoreDataManager.shared.income[indexPath.row]
        
        cell.configure(with: deposit)
        

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
            let income = CoreDataManager.shared.income[indexPath.row]
            CoreDataManager.shared.deleteIncome(income: income)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTransactionVC" {
            guard let indexPath = incomeTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? IncomeTableViewController else { return }
            
            let transactionToSend = CoreDataManager.shared.income[indexPath.row]
            destinationVC.deposits = [transactionToSend]
        }
    }
}

extension IncomeTableViewController: DeleteIncomeDelegate {
    func deleteIncome(income: Transaction) {
        guard let index = deposits.firstIndex(of: income) else { return }
        deposits.remove(at: index)
        incomeTableView.reloadData()
    }
    
    
}
