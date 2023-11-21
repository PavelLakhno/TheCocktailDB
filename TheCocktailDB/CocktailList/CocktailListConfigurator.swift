//
//  CocktailListConfigurator.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

protocol CocktailListConfiguratorInputProtocol {
    func configure(withView view: CocktailListViewController)
}

class CocktailListConfigurator: CocktailListConfiguratorInputProtocol {
    func configure(withView view: CocktailListViewController) {
        let presenter = CocktailListPresenter(view: view)
        let interactor = CocktailListInteractor(presenter: presenter)
        let router = CocktailListRouter(view: view)

        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
