//
//  StockTrackerViewController.swift
//  BudgetView
//
//  Created by Stef Castillo on 3/12/23.
//

import UIKit

class StockTrackerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    //MARK: - Outlets
    
    @IBOutlet weak var stockSearchBar: UISearchBar!
    @IBOutlet weak var stockTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stockSearchBar.delegate = self
        stockTableView.dataSource = self
        stockTableView.delegate = self
    }
    
    //MARK: - Methods
    func fetchStockAndUpdateViews(stock: SearchServerModel) {
        APICaller.shared.search(query: stock.description) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let stock):
                    self.StockFinderTableViewCell.symbolLabel
                }
            }
        }
    }
    
    
    //MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
        
        APICaller.shared.search(query: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let stock):
                    self.
                }
            }
        }
        
    }
}
