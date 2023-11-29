//
//  CocktailDetailsInteractor.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

protocol CocktailDetailsBusinessLogic {
    func provideCocktailDetails()
    func setFavoriteStatus()
    func fetchImageCocktail()
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
        
        let response = CocktailDetails.ShowDetails.Response(
            cocktailInstruction: cocktail?.strInstructions,
            measures: cocktail?.getMeasures() ?? [""],
            ingridients: cocktail?.getIngredients() ?? [""],
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
    
    func fetchImageCocktail() {
        worker?.fetchImage(from: cocktail?.strDrinkThumb, completion: {[weak self] imageData in
            let response = CocktailDetails.ShowImage.Response(imageURL: imageData)
            self?.presenter?.presentImageCocktail(response: response)
        })
    }
}
