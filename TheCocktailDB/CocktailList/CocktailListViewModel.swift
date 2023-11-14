//
//  CocktailListViewModel.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 14.11.2023.
//

import Foundation

protocol CocktailListViewModelProtocol {
    func fetchCocktails(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func getCocktailCellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol
    func getCocktailDetailsViewModel(at indexPath: IndexPath) -> CocktailDetailsViewModelProtocol
}

class CocktailListViewModel: CocktailListViewModelProtocol {

    private var cocktails: [Cocktail] = []
    
    func fetchCocktails(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchCocktails(from: Link.cocktailsURL.rawValue) { [unowned self]
            result in
            switch result{
            case .success(let cocktails):
                for cocktail in cocktails.drinks {
                    self.cocktails.append(cocktail)
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        cocktails.count
    }

    func getCocktailCellViewModel(at indexPath: IndexPath) -> CocktailCellViewModelProtocol {
        CocktailCellViewModel(cocktail: cocktails[indexPath.row])
    }
    
    func getCocktailDetailsViewModel(at indexPath: IndexPath) -> CocktailDetailsViewModelProtocol {
        CocktailDetailsViewModel(cocktail: cocktails[indexPath.row])
    }
    
}
