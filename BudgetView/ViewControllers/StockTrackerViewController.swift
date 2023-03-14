//
//  StockTrackerViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/12/23.
//

import UIKit

class StockTrackerViewController: UIViewController {
    

    
    
    //MARK: - Outlets
    
    @IBOutlet weak var stockSearchBar: UISearchBar!
    @IBOutlet weak var stockTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stockSearchBar.delegate = self
//        stockTableView.dataSource = self
//        stockTableView.delegate = self
        
        hideKeyboard()
    }
    
    //MARK: - Methods
    //****Review with Chris****
    func fetchStockAndUpdateViews(stock: SearchServerModel, price: QuoteServerModel, tableView: UITableView) {
        APICaller.shared.search(query: stock.description) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let searchResults):
                    let searchResult = searchResults
                    
                    APICaller.shared.search(query: stock.symbol) { result in
                        DispatchQueue.main.async {
                            switch result {
                                
                            case .success(let stockPrice):
                                let cell = tableView.dequeueReusableCell(withIdentifier: "stockFinderCell") as! StockFinderTableViewCell
                                cell.configure(with: searchResult, stockPrice: price)
                            case .failure(let error):
                                
                                print("Failed to fetch stock price: \(error.localizedDescription)")
                            }
                        }
                    }
                case .failure(let errror):
                    
                    print("Failed to search for stocks: \(errror.localizedDescription)")
                }
            }
        }
    }
    
    
    //MARK: - Table View Data Source
    
    //***Review with Chris**
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
    
    //MARK: - Methods
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension StockTrackerViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }

//        APICaller.shared.search(query: searchText) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let stock):
//                    self.fetchStockAndUpdateViews(stock: stock, price: , tableView: <#T##UITableView#>)
//                }
//            }
//        }

    }
}
