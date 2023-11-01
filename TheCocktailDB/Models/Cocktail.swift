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
}
