//
//  CocktailListConfigurator.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

final class CocktailListConfigurator {
    static let shared = CocktailListConfigurator()
    
    private init() {}
    
    func configure(withView viewController: CocktailListViewController) {
        let presenter = CocktailListPresenter()
        let interactor = CocktailListInteractor()
        let router = CocktailListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
