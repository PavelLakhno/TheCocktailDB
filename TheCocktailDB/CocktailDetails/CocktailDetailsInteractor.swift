//
//  CocktailDetailsInteractor.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

protocol CocktailDetailsBusinessLogic {
    func provideCocktailDetails()//request: CocktailDetails.ShowDetails.Request)
    func setFavoriteStatus()
}

protocol CocktailDetailsDataStore {
    var cocktail: Cocktail? { get set }
    var isFavorite: Bool { get }
}

class CocktailDetailsInteractor: CocktailDetailsBusinessLogic, CocktailDetailsDataStore {
    var cocktail: Cocktail?
    var isFavorite: Bool = false
    var presenter: CocktailDetailsPresentationLogic?
    var worker: CocktailDetailsWorker?
    
    func provideCocktailDetails() {
        worker = CocktailDetailsWorker()
        isFavorite = worker?.getFavoriteStatus(for: cocktail?.strDrink ?? "") ?? false
        let imageData = worker?.getImage(from: cocktail?.strDrinkThumb)
        
        let response = CocktailDetails.ShowDetails.Response(
            cocktailInstruction: cocktail?.strInstructions,
            measures: cocktail?.getMeasures() ?? [""],
            ingridients: cocktail?.getIngredients() ?? [""],
            imageURL: imageData,
            isFavorite: isFavorite
        )
        presenter?.presentCocktailDetails(response: response)
    }
    
    func setFavoriteStatus() {
        isFavorite.toggle()
        worker?.setNewFavoriteStatus(for: cocktail?.strDrink ?? "", with: isFavorite)
        
        let response = CocktailDetails.SetFavoriteStatus.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
    }
    
}
