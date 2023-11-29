//
//  CocktailDetailsModel.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 21.11.2023.
//
import Foundation

enum CocktailDetails {
    
    // MARK: UseCases
    enum ShowDetails {
       
        struct Response {
            let cocktailInstruction: String?
            let measures: [String?]
            let ingridients: [String?]
            let isFavorite: Bool
        }
        
        struct ViewModel {
            let cocktailInstruction: String
            let measures: [String?]
            let ingridients: [String?]
            let isFavorite: Bool
        }
    }
    
    enum SetFavoriteStatus {
        struct Response {
            let isFavorite: Bool
        }
        
        struct ViewModel {
            let isFavorite: Bool
        }
    }
    
    enum ShowImage {
        struct Response {
            let imageURL: Data?
        }
        
        struct ViewModel {
            let imageURL: Data
        }
    }
}
