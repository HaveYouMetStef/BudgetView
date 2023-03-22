//
//  StockFinderTableViewCell.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/12/23.
//

import UIKit

class StockFinderTableViewCell: UITableViewCell {
    
    
    //MARK: - Outlets
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    
    func configure(with search: SearchServerModel) {
        symbolLabel.text = search.symbol
        companyNameLabel.text = search.description
        
        APICaller.shared.stockPrice(for: search.symbol) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stockPrice):
                    if stockPrice.current > 0.0 {
                        self.configure(with: stockPrice)
                    }
                case .failure(let error):
                    self.stockPriceLabel.text = "N/A"
                }
            }
        }
    }
    
    func configure(with stockPrice: QuoteServerModel) {
                stockPriceLabel.text = "$" + String(format: "%.2f", stockPrice.current)
    }
    



}
