//
//  CocktailListPresenter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

protocol CocktailListPresentationLogic {
    func presentCocktails(response: CocktailList.ShowCocktails.Response)
}

class CocktailListPresenter: CocktailListPresentationLogic {

    weak var viewController: CocktailListDisplayLogic?

    func presentCocktails(response: CocktailList.ShowCocktails.Response) {
        let rows: [CocktailCellViewModelProtocol] = response.cocktails.map {
            CocktailCellViewModel(cocktail: $0)
        }
        let viewModel = CocktailList.ShowCocktails.ViewModel(rows: rows)
        viewController?.displayCocktails(viewModel: viewModel)
    }

}
