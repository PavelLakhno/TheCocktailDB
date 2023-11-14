//
//  CocktailCellViewModel.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 14.11.2023.
//

import Foundation

protocol CocktailCellViewModelProtocol {
    var cocktailName: String { get }
    var cocktailAlchohol: String { get }
    init(cocktail: Cocktail)
    func fetchImageCocktail(completion: @escaping (Data) -> Void)
}

class CocktailCellViewModel: CocktailCellViewModelProtocol {
    var cocktailName: String {
        cocktail.strDrink
    }
    
    var cocktailAlchohol: String {
        cocktail.strAlcoholic
    }

    private let cocktail: Cocktail
    
    required init(cocktail: Cocktail) {
        self.cocktail = cocktail
    }
    
    func fetchImageCocktail(completion: @escaping (Data) -> Void) {
        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
