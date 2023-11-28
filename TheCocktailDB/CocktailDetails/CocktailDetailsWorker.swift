//
//  CocktailDetailsWorker.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 22.11.2023.
//

import Foundation

class CocktailDetailsWorker {
    func getImage(from imageURL: String?) -> Data? {
        NetworkManager.shared.fetchImageData(from: imageURL)
    }
    
    func getFavoriteStatus(for cocktailName: String) -> Bool {
        DataManager.shared.loadFavoriteStatus(for: cocktailName)
    }
    
    func setNewFavoriteStatus(for cocktailName: String, with status: Bool) {
        DataManager.shared.saveFavoriteStatus(for: cocktailName, with: status)
    }

}
