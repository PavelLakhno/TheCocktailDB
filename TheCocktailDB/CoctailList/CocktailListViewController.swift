//
//  CocktailListViewController.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 31.10.2023.
//

import UIKit

class CocktailListViewController: UITableViewController {
    
    private var cocktails: [Cocktail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CocktailCell.self, forCellReuseIdentifier: CocktailCell.cellID)
        tableView.rowHeight = 100
        fetchProduct()
    }
}

// MARK: UITableViewDataSource
extension CocktailListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CocktailCell.cellID, for: indexPath)
        guard let cell = cell as? CocktailCell else { return UITableViewCell() }
        cell.configure(with: cocktails[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let infoCocktailVC = CocktailDetailsViewController()
        infoCocktailVC.cocktail = cocktails[indexPath.row]
        navigationController?.pushViewController(infoCocktailVC, animated: true)
    }
}

// MARK: API request
extension CocktailListViewController {
    
    private func fetchProduct() {
        NetworkManager.shared.fetchCocktails(from: Link.cocktailsURL.rawValue) { [weak self]
            result in
            switch result{
            case .success(let cocktails):
                for cocktail in cocktails.drinks {
                    self?.cocktails.append(cocktail)
                }
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
