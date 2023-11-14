//
//  CocktailListViewController.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 31.10.2023.
//

import UIKit

class CocktailListViewController: UITableViewController {
    private var viewModel: CocktailListViewModelProtocol! {
        didSet {
            viewModel.fetchCocktails { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CocktailListViewModel()
        tableView.register(CocktailCell.self, forCellReuseIdentifier: CocktailCell.cellID)
        tableView.rowHeight = 100
    }

}

// MARK: UITableViewDataSource
extension CocktailListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailCell.cellID, for: indexPath)
        guard let cell = cell as? CocktailCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCocktailCellViewModel(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let detailsVC = CocktailDetailsViewController()
        detailsVC.viewModel = viewModel.getCocktailDetailsViewModel(at: indexPath)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

