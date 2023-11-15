//
//  CocktailDetailsInteractor.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

protocol CocktailDetailsInteractorInputProtocol {
    init(presenter: CocktailDetailsInteractorOutputProtocol, cocktail: Cocktail)
    func provideCocktailDetails()

}

protocol CocktailDetailsInteractorOutputProtocol: AnyObject {
    func receiveCoctailDetails(with dataStore: CocktailDetailsDataStore)
//    func receiveFavoriteStatus(with status: Bool)
}

class CocktailDetailsInteractor: CocktailDetailsInteractorInputProtocol {
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
            measures: cocktail.getMeasures()
        )
        presenter.receiveCoctailDetails(with: dataStore)

    }
}
