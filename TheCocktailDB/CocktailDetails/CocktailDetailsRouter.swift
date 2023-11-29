//
//  CocktailDetailsRouter.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 22.11.2023.
//

import Foundation
import UIKit

protocol CocktailDetailsRoutingLogic {

}

protocol CocktailDetailsDataPassing {
    var dataStore: CocktailDetailsDataStore? { get }
}

class CocktailDetailsRouter: CocktailDetailsRoutingLogic, CocktailDetailsDataPassing {
    
    weak var viewController: CocktailDetailsViewController?
    var dataStore: CocktailDetailsDataStore?
}
