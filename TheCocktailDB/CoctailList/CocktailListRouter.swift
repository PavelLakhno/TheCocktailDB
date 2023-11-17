//
//  CocktailListRouter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

protocol CocktailListRouterInputProtocol {
    init(view: CocktailListViewController)
    func openCocktailDetailsViewController(with cocktail: Cocktail)
}

class CocktailListRouter: CocktailListRouterInputProtocol {
    private unowned let view: CocktailListViewController

    required init(view: CocktailListViewController) {
        self.view = view
    }

    func openCocktailDetailsViewController(with cocktail: Cocktail) {
        view.performSegue(withIdentifier: "showDetails", sender: cocktail)
    }
}
