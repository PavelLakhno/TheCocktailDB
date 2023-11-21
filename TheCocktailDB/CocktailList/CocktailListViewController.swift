//
//  CocktailListViewController.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 31.10.2023.
//

import UIKit

protocol CocktailListViewInputProtocol: AnyObject {
    func reloadData(for section: CocktailSectionViewModel)
}

protocol CocktailListViewOutputProtocol {
    init(view: CocktailListViewInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
}

class CocktailListViewController: UITableViewController {
    var presenter: CocktailListViewOutputProtocol!
    private var configurator: CocktailListConfiguratorInputProtocol = CocktailListConfigurator()
    private var sectionViewModel: CocktailSectionViewModelProtocol = CocktailSectionViewModel()
    private var cocktails: [Cocktail] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self)
        tableView.register(CocktailCell.self, forCellReuseIdentifier: "Cell")
        presenter.viewDidLoad()
    }
}

// MARK: UITableViewDataSource
extension CocktailListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionViewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sectionViewModel.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.cellIdentifier, for: indexPath)
        guard let cell = cell as? CocktailCell else { return UITableViewCell() }
        cell.viewModel = cellViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.didTapCell(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sectionViewModel.rows[indexPath.row].cellHeight
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

extension CocktailListViewController : CocktailListViewInputProtocol {
    func reloadData(for section: CocktailSectionViewModel) {
        sectionViewModel = section
        tableView.reloadData()
    }
}
