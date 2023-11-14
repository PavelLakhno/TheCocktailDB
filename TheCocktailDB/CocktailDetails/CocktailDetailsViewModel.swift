//
//  CocktailDetailsViewModel.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 13.11.2023.
//

import Foundation

protocol CocktailDetailsViewModelProtocol {
    var instruction: String { get }
    var isFavorite: Bool { get }
    var ingridients: [String?] { get }
    var measures: [String?] { get }
    var viewModelDidChange: ((CocktailDetailsViewModelProtocol) -> Void)? { get set }
    init(cocktail: Cocktail)
    func favoriteButtonPressed()
    func fetchImageCocktail(completion: @escaping (Data) -> Void)
}

class CocktailDetailsViewModel: CocktailDetailsViewModelProtocol {
     var instruction: String {
        cocktail.strInstructions
    }
    
    var isFavorite: Bool {
        get {
            DataManager.shared.loadFavoriteStatus(for: cocktail.strDrink)
        } set {
            DataManager.shared.saveFavoriteStatus(for: cocktail.strDrink, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var ingridients: [String?] {
        cocktail.getIngredients()
    }
    
    var measures: [String?] {
        cocktail.getMeasures()
    }

    var viewModelDidChange: ((CocktailDetailsViewModelProtocol) -> Void)?
    
    private let cocktail: Cocktail
    
    required init(cocktail: Cocktail) {
        self.cocktail = cocktail
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
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
