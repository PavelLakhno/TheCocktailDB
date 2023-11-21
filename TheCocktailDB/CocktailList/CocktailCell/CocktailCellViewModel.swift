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
    init(cocktail: Cocktail)
    func fetchImageCocktail(completion: @escaping (Data) -> Void)
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

    private let cocktail: Cocktail
    
    required init(cocktail: Cocktail) {
        self.cocktail = cocktail
    }
    
    func fetchImageCocktail(completion: @escaping (Data) -> Void) {
        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

class CocktailSectionViewModel: CocktailSectionViewModelProtocol {
    var rows: [CocktailCellViewModelProtocol] = []
    var numberOfRows: Int {
        rows.count
    }
}
