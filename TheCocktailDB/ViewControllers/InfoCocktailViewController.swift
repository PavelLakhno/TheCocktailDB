//
//  InfoCocktailViewController.swift
//  TheCocktailDB
//
//  Created by user on 30.10.2023.
//

import UIKit

class InfoCocktailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var cocktail: Cocktail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        ImageManager.shared.fetchImage(from: cocktail.strDrinkThumb) { [weak self]
            result in
            switch result {
            case .success(let image):
                print(image)
                self?.imageView.image = UIImage(data: image)
            case .failure(let error):
                print(error)
            }
        }
        
    }


}

