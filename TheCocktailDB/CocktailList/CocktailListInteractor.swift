//
//  CocktailListInteractor.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

protocol CocktailListBusinessLogic {
    func fetchCocktails()
}

protocol CocktailListDataStore {
    var cocktails: [Cocktail] { get }
}

class CocktailListInteractor: CocktailListBusinessLogic, CocktailListDataStore {

    var presenter: CocktailListPresentationLogic?
    var cocktails: [Cocktail] = []
    
    func fetchCocktails() {
        NetworkManager.shared.fetchCocktails(from: Link.cocktailsURL.rawValue) { [weak self]
            result in
            switch result{
            case .success(let cocktails):
                for cocktail in cocktails.drinks {
                    self?.cocktails.append(cocktail)
                }
                let response = CocktailList.ShowCocktails.Response(cocktails: self?.cocktails ?? [])
                self?.presenter?.presentCocktails(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
