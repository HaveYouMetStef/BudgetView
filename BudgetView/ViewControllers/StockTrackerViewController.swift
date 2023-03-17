//
//  StockTrackerViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/12/23.
//

import UIKit

class StockTrackerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: Properties
    var stock: [SearchServerModel] = []
    var price: [QuoteServerModel] = []
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var stockSearchBar: UISearchBar!
    @IBOutlet weak var stockTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockSearchBar.delegate = self
        stockTableView.dataSource = self
        stockTableView.delegate = self
        fetchStockAndUpdateViews(stock: "Apple")
        fetchStockPriceAndUpdateViews(stock: "AAPL")
        
        
        hideKeyboard()
    }
    
    //MARK: - Methods
    //****Review with Chris****
    func fetchStockAndUpdateViews(stock: String) {
        APICaller.shared.search(query: stock) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let searchResults):
                    let searchResult = searchResults
                    print(searchResult)
                    
                    //                    APICaller.shared.search(query: stock.symbol) { result in
                    //                        DispatchQueue.main.async {
                    //                            switch result {
                    //
                    //                            case .success(let stockPrice):
                    //                                let cell = tableView.dequeueReusableCell(withIdentifier: "stockFinderCell") as! StockFinderTableViewCell
                    //                                cell.configure(with: searchResult, stockPrice: price)
                    //                            case .failure(let error):
                    //
                    //                                print("Failed to fetch stock price: \(error.localizedDescription)")
                    //                            }
                    //                        }
                    //                    }
                case .failure(let errror):
                    
                    print("Failed to search for stocks: \(errror.localizedDescription)")
                }
            }
        }
    }
    
    func fetchStockPriceAndUpdateViews(stock: String) {
        APICaller.shared.stockPrice(for: stock) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let stockPrices):
                    let stockPrice = stockPrices
                    print(stockPrice)
                    
                case .failure(let error):
                    print("Failed to search for stock price: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    //MARK: - Table View Data Source
    
    //***Review with Chris**
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stock.isEmpty ? 0 : stock.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stockFinderCell", for: indexPath) as? StockFinderTableViewCell else {
            return UITableViewCell()
        }
        
        let stock = self.stock[indexPath.row]
        let stockPrice = self.price[indexPath.row]
        
        cell.configure(with: stock)
        cell.configure(with: stockPrice)
        
//        if indexPath.row < self.price.count {
//            let stockPrice = self.price[indexPath.row]
//            cell.configure(with: stock)
//        }
        
//        if !stock.isEmpty {
//            let stock = stock[indexPath.row]
//            let stockPrice = price[indexPath.row]
//            cell.configure(with: stock, stockPrice: stockPrice)
//        }
////        cell.configure(with: stock)
//
////        cell.stockModel = stock
        
        return cell
    }
    
    //MARK: - Methods
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        
        view.endEditing(true)
    }
    
    
}

extension StockTrackerViewController: UISearchBarDelegate {
    
    
    ///runs when you search in text bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //text longer than 3 characters, api call, store results in array(stock array), pass item to the cell
        
        guard let searchTerm = searchBar.text else { return }
        
        if searchTerm.count >= 3 {
            APICaller.shared.search(query: searchText) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let stock):
                        self.stock = stock.result
                        self.stockTableView.reloadData()
                        
                        for stocks in stock.result {
                            APICaller.shared.stockPrice(for: stocks.symbol) { result  in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success(let stockPrice):
                                        let newPrice = QuoteServerModel(current: stockPrice.current)
                                        
                                        if let index = self.stock.firstIndex(where: { $0.symbol == stocks.symbol })
                                            self.price[index] = newPrice
                                            self.stockTableView.reloadData()
                                    }
                                }
                            }
                        }
                        
                    case .failure(let error):
                        print("Failed to search for stock name: \(error.localizedDescription)")
                    }
                }
            }
            APICaller.shared.stockPrice(for: searchText) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let stockPrice):
                        let newPrice = QuoteServerModel(current: stockPrice.current)
                        self.price.append(newPrice)
                        self.stockTableView.reloadData()
                        
                    case .failure(let error):
                        print("Failed to search for stock price: \(error.localizedDescription)")
                    }
                }
            }
            
            
        }
    }
    
    
}
