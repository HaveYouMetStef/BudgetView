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
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        footer.backgroundColor = UIColor(red: 59/255, green: 159/255, blue: 111/255, alpha: 1.0)
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.frame.width - 30, height: 20))
        titleLabel.textAlignment = .center

        
//        let screenWidth = UIScreen.main.bounds.width
        let amountTotal = UILabel(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 10, width: tableView.frame.width, height: 30))
        footer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        titleLabel.textColor = .white
        titleLabel.text = "Monthly Income"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        amountTotal.font = UIFont.systemFont(ofSize: 20)
        
        amountTotal.textColor = .white
        amountTotal.textAlignment = .center
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        amountTotal.text = "$" + (formatter.string(from: NSNumber(value: CoreDataManager.shared.totalIncome())) ?? "0.00")
        footer.layer.cornerRadius = 10
        
        
        footer.addSubview(titleLabel)
        footer.addSubview(amountTotal)
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let income = CoreDataManager.shared.income[indexPath.row]
            CoreDataManager.shared.deleteIncome(income: income)
            tableView.reloadData()
            
        }
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditIncomeTransaction" {
            guard let indexPath = incomeTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? AddTransactionViewController else { return }
            
            let transactionToSend = CoreDataManager.shared.income[indexPath.row]
            
            destinationVC.editTransaction = transactionToSend
            destinationVC.isIncomeType = true
        }
        else if segue.identifier == "toTransactionVC" {
                 guard let destinationVC = segue.destination as? AddTransactionViewController else {
                return
            }
            
            destinationVC.isIncomeType = true
        }
    }
}

