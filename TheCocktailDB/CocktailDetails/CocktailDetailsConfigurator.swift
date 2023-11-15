//
//  CocktailDetailsConfigurator.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

protocol CocktailDetailsConfiguratorInputProtocol {
    func configure(withView view: CocktailDetailsViewController, and cocktail: Cocktail)
}

class CocktailDetailsConfigurator: CocktailDetailsConfiguratorInputProtocol {
    func configure(withView view: CocktailDetailsViewController, and cocktail: Cocktail) {
        let presenter = CocktailDetailsPresenter(view: view)
        let interactor = CocktailDetailsInteractor(presenter: presenter, cocktail: cocktail)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
