//
//  DataManager.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 09.11.2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func saveFavoriteStatus(for cocktailName: String, with status: Bool) {
        userDefaults.set(status, forKey: cocktailName)
    }
    
    func loadFavoriteStatus(for cocktailName: String) -> Bool {
        userDefaults.bool(forKey: cocktailName)
    }
}
