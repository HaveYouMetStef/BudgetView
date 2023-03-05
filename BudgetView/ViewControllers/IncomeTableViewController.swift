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
        return CoreDataManager.shared.income.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as? IncomeTableViewCell
        else { return UITableViewCell()}
        
        let deposit = CoreDataManager.shared.income[indexPath.row]
        
        cell.configure(with: deposit)
        
//        let deposit = deposits[indexPath.row]
        
        cell.textLabel?.text = deposit.name
        cell.textLabel?.text = String(deposit.amount)
        cell.textLabel?.text = (deposit.date?.formatted(date: .abbreviated, time: .complete))
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
