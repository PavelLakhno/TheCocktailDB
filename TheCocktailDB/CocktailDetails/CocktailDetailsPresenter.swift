//
//  CocktailDetailsPresenter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

protocol CocktailDetailsPresentationLogic {
    func presentCocktailDetails(response: CocktailDetails.ShowDetails.Response)
    func presentFavoriteStatus(response: CocktailDetails.SetFavoriteStatus.Response)
}

class CocktailDetailsPresenter: CocktailDetailsPresentationLogic {
    
    weak var viewController: CocktailDetailsDisplayLogic?
    
    func presentCocktailDetails(response: CocktailDetails.ShowDetails.Response) {
        let viewModel = CocktailDetails.ShowDetails.ViewModel(
            cocktailInstruction: response.cocktailInstruction ?? "",
            measures: response.measures,
            ingridients: response.ingridients,
            imageURL: response.imageURL ?? Data(),
            isFavorite: response.isFavorite
        )
        viewController?.displayCocktailDetails(viewModel: viewModel)
    }
    
    func presentFavoriteStatus(response: CocktailDetails.SetFavoriteStatus.Response) {
        let viewModel = CocktailDetails.SetFavoriteStatus.ViewModel(isFavorite: response.isFavorite)
        viewController?.displayFavoriteButtonStatus(viewModel: viewModel)
    }
}
