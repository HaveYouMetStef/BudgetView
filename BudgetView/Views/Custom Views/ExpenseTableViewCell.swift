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
        expenseAmountLabel.text = "$" + String(format: "%.2f", transaction.amount)
    }

}
