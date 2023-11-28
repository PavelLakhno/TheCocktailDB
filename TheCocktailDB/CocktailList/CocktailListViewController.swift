//
//  CocktailListViewController.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 31.10.2023.
//

import UIKit

protocol CocktailListDisplayLogic: AnyObject {
    func displayCocktails(viewModel: CocktailList.ShowCocktails.ViewModel)
}

class CocktailListViewController: UITableViewController {
    
    var interactor: CocktailListBusinessLogic?
    var router: (CocktailListRoutingLogic & CocktailListDataPassing)?
    
    private var rows: [CocktailCellViewModelProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        CocktailListConfigurator.shared.configure(withView: self)
        tableView.register(CocktailCell.self, forCellReuseIdentifier: "Cell")
        showCocktails()
    }
    
    private func showCocktails() {
        interactor?.fetchCocktails()
    }
}

// MARK: UITableViewDataSource
extension CocktailListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier, for: indexPath)
        guard let cell = cell as? CocktailCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        router?.navigateToPushedViewController(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rows[indexPath.row].height
    }
}

// MARK: API request
extension CocktailListViewController: CocktailListDisplayLogic {
    func displayCocktails(viewModel: CocktailList.ShowCocktails.ViewModel) {
        rows = viewModel.rows
        tableView.reloadData()
    }
}

