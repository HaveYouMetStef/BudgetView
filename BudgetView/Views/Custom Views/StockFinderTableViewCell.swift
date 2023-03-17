//
//  StockFinderTableViewCell.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/12/23.
//

import UIKit

class StockFinderTableViewCell: UITableViewCell {
    
    var stockModel: SearchServerModel? {
        didSet {
            updateViews()
        }
    }
    var stockPrice: QuoteServerModel? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    func configure(with search: SearchServerModel) {
        symbolLabel.text = search.symbol
        companyNameLabel.text = search.description
    }
    
    func configure(with stockPrice: QuoteServerModel) {
                stockPriceLabel.text = "$" + String(format: "%.2f", stockPrice.current)
    }
    
    func updateViews() {
        guard let stock = stockModel else { return }
        guard let stockPrices = stockPrice else { return }
        
        symbolLabel.text = stock.displaySymbol
        companyNameLabel.text = stock.description
        stockPriceLabel.text = String(stockPrices.current)
        
        
        
    }



}
