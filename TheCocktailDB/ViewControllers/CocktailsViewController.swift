//
//  CocktailsViewController.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 31.10.2023.
//

import UIKit

class CocktailsViewController: UITableViewController {
    
    private var cocktails: [Cocktail] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        fetchProduct()

    }

    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.secondaryText = cocktails[indexPath.row].strDrink
        content.image = UIImage(named: cocktails[indexPath.row].strDrinkThumb)

        content.imageProperties.maximumSize = CGSize(width: 40.0, height: 40.0)
        cell.contentConfiguration = content
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoCocktailVC = segue.destination as? InfoCocktailViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        infoCocktailVC?.cocktail = cocktails[indexPath.row]
    }


}

extension CocktailsViewController {
    
    private func fetchProduct() {
        NetworkManager.shared.fetchCocktails(from: Link.cocktailsURL.rawValue) { [weak self]
            result in
            switch result{
            case .success(let cocktails):
                for cocktail in cocktails.drinks {
                    self?.cocktails.append(cocktail)
                }
                self?.tableView.reloadData()
                print(cocktails.drinks.count)
        
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    private func fetchImage(name: String) {
//        NetworkManager.shared.fetchImage(from: name) { [weak self] result in
//            switch result {
//            case .success(let data):
//
//            }
//        }
//    }
}
