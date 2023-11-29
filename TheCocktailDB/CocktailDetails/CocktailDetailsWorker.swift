//
//  CocktailDetailsWorker.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 22.11.2023.
//

import Foundation

class CocktailDetailsWorker {
    func fetchImage(from imageURL: String?, completion: @escaping (Data) -> Void)   {
        NetworkManager.shared.fetchImage(from: imageURL) {result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getFavoriteStatus(for cocktailName: String) -> Bool {
        DataManager.shared.loadFavoriteStatus(for: cocktailName)
    }
    
    func setNewFavoriteStatus(for cocktailName: String, with status: Bool) {
        DataManager.shared.saveFavoriteStatus(for: cocktailName, with: status)
    }
}
