//
//  ExpenseTableViewCell.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/8/23.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var expenseDateLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    
    func configure(with transaction: Transaction) {
        expenseNameLabel.text = transaction.name
        guard let date = transaction.date else { return }
        expenseDateLabel.text = DateFormatter.transactionDate.string(from: transaction.date ?? Date())
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        
        if let expenseAmountString = formatter.string(from: NSNumber(value: transaction.amount)) {
            expenseAmountLabel.text = "$" + expenseAmountString
        } else {
            expenseAmountLabel.text = "$" + String(format: "%.2f", transaction.amount)
        }
//        expenseAmountLabel.text = "$" + String(format: "%.2f", transaction.amount)
    }

}
