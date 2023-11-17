//
//  CocktailCellViewModel.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 17.11.2023.
//

import Foundation

protocol CocktailCellViewModelProtocol {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
    var cocktailName: String { get }
    var cocktailAlchoholic: String { get }
    var imageData: Data? { get }
    init(cocktail: Cocktail)
}

protocol CocktailSectionViewModelProtocol {
    var rows: [CocktailCellViewModelProtocol] { get }
    var numberOfRows: Int { get }
}

class CocktailCellViewModel: CocktailCellViewModelProtocol {
    var cellIdentifier: String {
        "Cell"
    }
    
    var cellHeight: Double {
        100
    }
    
    var cocktailName: String {
        cocktail.strDrink
    }
    
    var cocktailAlchoholic: String {
        cocktail.strAlcoholic
    }
    
    var imageData: Data? {
        NetworkManager.shared.fetchImageData(from: cocktail.strDrinkThumb)
    }
    
    private let cocktail: Cocktail
    
    required init(cocktail: Cocktail) {
        self.cocktail = cocktail
    }
}

class CocktailSectionViewModel: CocktailSectionViewModelProtocol {
    var rows: [CocktailCellViewModelProtocol] = []
    var numberOfRows: Int {
        rows.count
    }
}
