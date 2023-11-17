//
//  CocktailDetailsPresenter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

struct CocktailDetailsDataStore {
    let cocktailInstruction: String
    let ingridients: [String?]
    let measures: [String?]
    let imageData: Data?
    let isFavorite: Bool
}

class CocktailDetailsPresenter: CocktailDetailsViewOutputProtocol {
    var interactor: CocktailDetailsInteractorInputProtocol!
    private unowned let view: CocktailDetailsViewInputProtocol
    
    required init(view: CocktailDetailsViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideCocktailDetails()
    }

    func favoriteButtonPressed() {
        interactor.toggleFavoriteStatus()
    }
}

// MARK: CocktailDetailsInteractorOutputProtocol
extension CocktailDetailsPresenter: CocktailDetailsInteractorOutputProtocol {

    func receiveCoctailDetails(with dataStore: CocktailDetailsDataStore) {
        let ingridients = dataStore.ingridients
        let measures = dataStore.measures
        view.displayCocktailInstruction(with: dataStore.cocktailInstruction)
        view.displayCocktailComposition(ingridients, and: measures)
        view.displayImageForFavoriteButton(with: dataStore.isFavorite)
        
        guard let imageData = dataStore.imageData else { return }
        view.displayImage(with: imageData)
    }
    
    func receiveFavoriteStatus(with status: Bool) {
        view.displayImageForFavoriteButton(with: status)
    }
    
}
