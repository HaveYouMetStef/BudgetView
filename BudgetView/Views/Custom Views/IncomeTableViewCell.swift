//
//  IncomeTableViewCell.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/5/23.
//

import UIKit

class IncomeTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configure(with transaction: Transaction) {
        transactionLabel.text = transaction.name
        guard let date = transaction.date else {
            print("hello")
            return
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        dateLabel.text = DateFormatter.transactionDate.string(from: transaction.date ?? Date())
        if let amountString = formatter.string(from: NSNumber(value: transaction.amount)) {
            amountLabel.text = "$" + amountString
        } else {
            amountLabel.text = "$" + String(format: "%.2f", transaction.amount)
        }
    }
    


}
