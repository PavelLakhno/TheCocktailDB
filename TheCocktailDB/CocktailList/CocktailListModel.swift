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
    init(cocktail: Cocktail)
    func fetchImageCocktail(completion: @escaping (Data) -> Void)
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
                
                private let cocktail: Cocktail
                
                init(cocktail: Cocktail) {
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
            let rows: [CocktailCellViewModelProtocol]
        }
    }
}
