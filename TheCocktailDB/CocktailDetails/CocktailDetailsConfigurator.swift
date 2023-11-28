//
//  CocktailDetailsConfigurator.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

final class CocktailDetailsConfigurator {
    static let shared = CocktailDetailsConfigurator()
    
    private init() {}
    
    func configure(with viewController: CocktailDetailsViewController) {
        let interactor = CocktailDetailsInteractor()
        let presenter = CocktailDetailsPresenter()
        let router = CocktailDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router 
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

