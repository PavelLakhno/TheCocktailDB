//
//  CocktailListInteractor.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

protocol CocktailListInteractorInputProtocol {
    init(presenter: CocktailListInteractorOutputProtocol)
    func fetchCocktails()
}

protocol CocktailListInteractorOutputProtocol: AnyObject {
    func cocktailsDidReceive(with dataStore: CocktailListDataStore)
}

class CocktailListInteractor: CocktailListInteractorInputProtocol {
    private unowned let presenter: CocktailListInteractorOutputProtocol

    required init(presenter: CocktailListInteractorOutputProtocol) {
        self.presenter = presenter
    }

    func fetchCocktails() {
        NetworkManager.shared.fetchCocktails(from: Link.cocktailsURL.rawValue) { [unowned self]
        result in
        switch result{
        case .success(let cocktails):
            let dataStore = CocktailListDataStore(cocktails: cocktails.drinks)
//            for cocktail in cocktails.drinks {
//                self.cocktails.append(cocktail)
//            }
            presenter.cocktailsDidReceive(with: dataStore)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    }
}
