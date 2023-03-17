//
//  StockFinderTableViewCell.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/12/23.
//

import UIKit

class StockFinderTableViewCell: UITableViewCell {
    
    var stockModel: SearchServerModel?
    
    //MARK: - Outlets
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    func configure(with search: SearchServerModel, stockPrice: QuoteServerModel) {
        symbolLabel.text = search.symbol
        companyNameLabel.text = search.description
        stockPriceLabel.text = "$" + String(format: "%.2f", stockPrice.current)
    }



}
