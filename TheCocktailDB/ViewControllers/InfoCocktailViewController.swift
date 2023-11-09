//
//  InfoCocktailViewController.swift
//  TheCocktailDB
//
//  Created by user on 30.10.2023.
//

import UIKit

class InfoCocktailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activIndicator = UIActivityIndicatorView(style: .large)
        activIndicator.translatesAutoresizingMaskIntoConstraints = false
        activIndicator.startAnimating()
        activIndicator.hidesWhenStopped = true
        return activIndicator
    }()
    
    var cocktail: Cocktail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.backgroundColor = .white
  
        imageView.addSubview(activityIndicator)
        fetchImage()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
        ])
    }
}

extension InfoCocktailViewController {
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) { [weak self]
            result in
            switch result {
            case .success(let image):
                print(image)
                self?.imageView.image = UIImage(data: image)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
