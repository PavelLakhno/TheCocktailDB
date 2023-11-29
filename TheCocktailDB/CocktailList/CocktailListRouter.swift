//
//  CocktailListRouter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 16.11.2023.
//

import Foundation

protocol CocktailListRoutingLogic {
    func navigateToPushedViewController(index: Int)
}

protocol CocktailListDataPassing {
    var dataStore: CocktailListDataStore? { get }
}

class CocktailListRouter: CocktailListRoutingLogic, CocktailListDataPassing {
    weak var viewController: CocktailListViewController?
    var dataStore: CocktailListDataStore?
    
    func navigateToPushedViewController(index: Int) {
        let destinationVC = CocktailDetailsViewController()
        var destinationDS = destinationVC.router?.dataStore
        destinationDS?.cocktail = dataStore?.cocktails[index]
        
        navigateToCocktailDetails(source: viewController, destination: destinationVC)
        passDataToCocktailDetails(source: dataStore, destination: &destinationDS)
    }
    
    // MARK: Navigation
    func navigateToCocktailDetails(source: CocktailListViewController?, destination: CocktailDetailsViewController) {
        source?.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    func passDataToCocktailDetails(source: CocktailListDataStore?, destination: inout CocktailDetailsDataStore?) {
        guard let indexPath = viewController?.tableView.indexPathForSelectedRow else { return }
        destination?.cocktail = source?.cocktails[indexPath.row]
    }
}
