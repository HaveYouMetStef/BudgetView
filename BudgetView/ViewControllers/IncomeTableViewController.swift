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
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.requestIncome()

        incomeTableView.delegate = self
        incomeTableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.requestIncome()
        incomeTableView.reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        incomeTableView.reloadData()
//    }

    // MARK: - Table view data source

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.income.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as? IncomeTableViewCell
        else { return UITableViewCell()}
        
        let deposit = CoreDataManager.shared.income[indexPath.row]
        
        cell.configure(with: deposit)
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor(red: 59/255, green: 159/255, blue: 111/255, alpha: 1.0)
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 10, width: 350, height: 30))
        let amountTotal = UILabel(frame: CGRect(x: 315, y: 10, width: 350, height: 30))
        titleLabel.textColor = .white
        titleLabel.text = "Monthly Income"
//        titleLabel.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        footer.addSubview(titleLabel)
        
        amountTotal.textColor = .white
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        amountTotal.text = "$" + (formatter.string(from: NSNumber(value: CoreDataManager.shared.totalIncome())) ?? "0.00")
//        amountTotal.text = "$" + String(format: "%.2f", CoreDataManager.shared.totalIncome())
        footer.addSubview(amountTotal)
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
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
            tableView.reloadData()
            
            //            CoreDataManager.shared.requestIncome()
            //            DispatchQueue.main.async {
            //                tableView.deleteRows(at: [indexPath], with: .fade)
            //            }
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
        if segue.identifier == "toEditIncomeTransaction" {
            guard let indexPath = incomeTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? AddTransactionViewController else { return }
            
            let transactionToSend = CoreDataManager.shared.income[indexPath.row]
            
            destinationVC.editTransaction = transactionToSend
        }
    }
}

