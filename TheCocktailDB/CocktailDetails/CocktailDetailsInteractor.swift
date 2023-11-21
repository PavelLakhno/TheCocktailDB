//
//  CocktailDetailsInteractor.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

protocol CocktailDetailsInteractorInputProtocol {
    var isFavorite: Bool { get }
    init(presenter: CocktailDetailsInteractorOutputProtocol, cocktail: Cocktail)
    func provideCocktailDetails()
    func toggleFavoriteStatus()
    func fetchImageCocktail()
}

protocol CocktailDetailsInteractorOutputProtocol: AnyObject {
    func receiveCoctailDetails(with dataStore: CocktailDetailsDataStore)
    func receiveFavoriteStatus(with status: Bool)
    func receiveImageCocktail(with imageData: Data)
}

class CocktailDetailsInteractor: CocktailDetailsInteractorInputProtocol {
   
    var isFavorite: Bool {
        get {
            DataManager.shared.loadFavoriteStatus(for: cocktail.strDrink)
        } set {
            DataManager.shared.saveFavoriteStatus(for: cocktail.strDrink, with: newValue)
        }
    }
    
    private unowned let presenter: CocktailDetailsInteractorOutputProtocol
    private let cocktail: Cocktail
    
    required init(presenter: CocktailDetailsInteractorOutputProtocol, cocktail: Cocktail) {
        self.presenter = presenter
        self.cocktail = cocktail
    }
    
    func provideCocktailDetails() {
        let dataStore = CocktailDetailsDataStore(
            cocktailInstruction: cocktail.strInstructions,
            ingridients: cocktail.getIngredients(),
            measures: cocktail.getMeasures(),
            isFavorite: isFavorite
        )
        presenter.receiveCoctailDetails(with: dataStore)
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        presenter.receiveFavoriteStatus(with: isFavorite)
    }
    
    func fetchImageCocktail() {
        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) {[unowned self] result in
            switch result {
            case .success(let data):
                presenter.receiveImageCocktail(with: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
