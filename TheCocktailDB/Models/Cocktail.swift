//
//  Cocktail.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 01.11.2023.
//

import Foundation

struct Drinks: Decodable {
    let drinks: [Cocktail]
}

struct Cocktail: Decodable {
    let strDrink: String
    let strAlcoholic: String
    let strInstructions: String
    let strDrinkThumb: String
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    
    func getIngredients() -> [String?] {
        [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6]
    }
    
    func getMeasures() -> [String?] {
        [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6]
    }
    
}


