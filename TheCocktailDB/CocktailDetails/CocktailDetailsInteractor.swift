//
//  CocktailDetailsInteractor.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 15.11.2023.
//

import Foundation

protocol CocktailDetailsInteractorInputProtocol {
    var isFavorite: Bool { get }
    init(presenter: CocktailDetailsInteractorOutputProtocol, cocktail: Cocktail)
    func provideCocktailDetails()
    func toggleFavoriteStatus()
//    func fetchImageCocktail(completion: @escaping (Data) -> Void)
}

protocol CocktailDetailsInteractorOutputProtocol: AnyObject {
    func receiveCoctailDetails(with dataStore: CocktailDetailsDataStore)
    func receiveFavoriteStatus(with status: Bool)
}

class CocktailDetailsInteractor: CocktailDetailsInteractorInputProtocol {
   
    var isFavorite: Bool {
        get {
            DataManager.shared.loadFavoriteStatus(for: cocktail.strDrink)
        } set {
            DataManager.shared.saveFavoriteStatus(for: cocktail.strDrink, with: newValue)
        }
    }
    
    private unowned let presenter: CocktailDetailsInteractorOutputProtocol
    private let cocktail: Cocktail
    
    required init(presenter: CocktailDetailsInteractorOutputProtocol, cocktail: Cocktail) {
        self.presenter = presenter
        self.cocktail = cocktail
    }
    
    func provideCocktailDetails() {
        let imageData = NetworkManager.shared.fetchImageData(from: cocktail.strDrinkThumb)
        let dataStore = CocktailDetailsDataStore(
            cocktailInstruction: cocktail.strInstructions,
            ingridients: cocktail.getIngredients(),
            measures: cocktail.getMeasures(),
            imageData: imageData,
            isFavorite: isFavorite
        )
        presenter.receiveCoctailDetails(with: dataStore)
    }
    
    func toggleFavoriteStatus() {
        isFavorite.toggle()
        presenter.receiveFavoriteStatus(with: isFavorite)
    }
    
//    func fetchImageCocktail(completion: @escaping (Data) -> Void) {
//        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) { result in
//            switch result {
//            case .success(let data):
//                completion(data)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
