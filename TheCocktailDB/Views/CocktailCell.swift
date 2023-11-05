//
//  CocktailCell.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 01.11.2023.
//

import UIKit

class CocktailCell: UITableViewCell {
    
    
    @IBOutlet var imageCocktailView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    
    func configure(with cocktail: Cocktail) {

        self.mainLabel.text = cocktail.strDrink
        self.secondaryLabel.text = cocktail.strAlcoholic

        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageCocktailView.image = UIImage(data: image)
            case .failure(let error):
                print(error)
            }
        }

    }
}
