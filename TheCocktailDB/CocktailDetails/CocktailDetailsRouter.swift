//
//  CocktailDetailsRouter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 22.11.2023.
//

import Foundation
import UIKit

/*@objc*/ protocol CocktailDetailsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CocktailDetailsDataPassing {
    var dataStore: CocktailDetailsDataStore? { get }
}

class CocktailDetailsRouter: CocktailDetailsRoutingLogic, CocktailDetailsDataPassing {
    
    weak var viewController: CocktailDetailsViewController?
    var dataStore: CocktailDetailsDataStore?
}
