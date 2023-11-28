//
//  CocktailListModel.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 23.11.2023.
//

import Foundation

typealias CocktailCellViewModel = CocktailList.ShowCocktails.ViewModel.CocktailCellViewModel

protocol CocktailCellViewModelProtocol {
    var identifier: String { get }
    var height: Double { get }
    var cocktailName: String { get }
    var cocktailAlchohol: String { get }
    var imageData: Data? { get }
    init(cocktail: Cocktail)
}

enum CocktailList {
    // MARK: UseCases
    enum ShowCocktails {
        
        struct Response {
            let cocktails: [Cocktail]
        }
        
        struct ViewModel {
            struct CocktailCellViewModel: CocktailCellViewModelProtocol {
                var identifier: String {
                    "Cell"
                }
                
                var height: Double {
                    100
                }
                
                var cocktailName: String {
                    cocktail.strDrink
                }
                
                var cocktailAlchohol: String {
                    cocktail.strAlcoholic
                }
                
                var imageData: Data? {
                    NetworkManager.shared.fetchImageData(from: cocktail.strDrinkThumb)
                }
                
                private let cocktail: Cocktail
                
                init(cocktail: Cocktail) {
                    self.cocktail = cocktail
                }
            }
            let rows: [CocktailCellViewModelProtocol]
        }
    }
}
