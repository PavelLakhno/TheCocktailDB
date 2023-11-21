//
//  CocktailListPresenter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

struct CocktailListDataStore {
    let cocktails: [Cocktail]
}

class CocktailListPresenter: CocktailListViewOutputProtocol {
    var interactor: CocktailListInteractorInputProtocol!
    var router: CocktailListRouterInputProtocol!

    private unowned let view: CocktailListViewInputProtocol
    private var dataStore: CocktailListDataStore?

    required init(view: CocktailListViewInputProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        interactor.fetchCocktails()
    }

    func didTapCell(at indexPath: IndexPath) {
        guard let cocktail = dataStore?.cocktails[indexPath.row] else { return }
        router.openCocktailDetailsViewController(with: cocktail)
    }
}

// MARK: - CocktailListInteractorOutputProtocol
extension CocktailListPresenter: CocktailListInteractorOutputProtocol {
    func cocktailsDidReceive(with dataStore: CocktailListDataStore) {
        self.dataStore = dataStore
        let section = CocktailSectionViewModel()
        dataStore.cocktails.forEach { section.rows.append(CocktailCellViewModel(cocktail: $0)) }
        view.reloadData(for: section)
    }
}
