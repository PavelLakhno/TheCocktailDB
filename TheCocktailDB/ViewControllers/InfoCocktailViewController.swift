//
//  InfoCocktailViewController.swift
//  TheCocktailDB
//
//  Created by user on 30.10.2023.
//

import UIKit

class InfoCocktailViewController: UIViewController {
    
    private lazy var imageCocktailView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let favButton = UIButton(configuration: .gray())
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favButton.tintColor = .white
        favButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return favButton
    }()
    
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private lazy var ingridientsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.sizeToFit()
        view.distribution = .fillEqually
        view.spacing = 10
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activIndicator = UIActivityIndicatorView(style: .large)
        activIndicator.translatesAutoresizingMaskIntoConstraints = false
        activIndicator.startAnimating()
        activIndicator.hidesWhenStopped = true
        return activIndicator
    }()
    
    var cocktail: Cocktail!
    
    private var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(imageCocktailView, favoriteButton, instructionLabel, ingridientsStackView)
        view.backgroundColor = .white
        imageCocktailView.addSubview(activityIndicator)
        instructionLabel.text = cocktail.strInstructions

        loadFavoriteStatus()
        fetchImage()
        createStackLabels()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageCocktailView.heightAnchor.constraint(equalToConstant: 250),
            imageCocktailView.widthAnchor.constraint(equalToConstant: 250),
            imageCocktailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageCocktailView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),

            activityIndicator.centerYAnchor.constraint(equalTo: imageCocktailView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: imageCocktailView.centerXAnchor),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.centerXAnchor.constraint(equalTo: imageCocktailView.trailingAnchor, constant: -40),
            favoriteButton.centerYAnchor.constraint(equalTo: imageCocktailView.bottomAnchor, constant: -40),
            
            instructionLabel.topAnchor.constraint(equalTo: imageCocktailView.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            instructionLabel.heightAnchor.constraint(equalToConstant: 100),
            
            ingridientsStackView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            ingridientsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            ingridientsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ingridientsStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    // MARK: - Actions
    @objc func toggleFavorite(_ sender: UIButton) {
        isFavorite.toggle()
        setImageForFavoriteButton()
        DataManager.shared.saveFavoriteStatus(for: cocktail.strDrink, with: isFavorite)
    }
    
    // MARK: - Private Methods
    private func setImageForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .red : .white
    }
    
    private func loadFavoriteStatus() {
        isFavorite = DataManager.shared.loadFavoriteStatus(for: cocktail.strDrink)
    }
    
    private func createStackLabels() {
        let ingridients = cocktail.getIngredients()
        let measures = cocktail.getMeasures()
        
        for i in 0...ingridients.count-1 {
            if ingridients[i] != nil {
                
                let stackView = UIStackView()
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.axis = .horizontal
                stackView.distribution = .fillProportionally
                stackView.spacing = 5
                
                let ingridientLabel = UILabel()
                ingridientLabel.translatesAutoresizingMaskIntoConstraints = false
                ingridientLabel.textAlignment = .left
                ingridientLabel.font = .boldSystemFont(ofSize: 15)
                ingridientLabel.numberOfLines = 0
                ingridientLabel.text = ingridients[i]
                
                let measureLabel = UILabel()
                measureLabel.translatesAutoresizingMaskIntoConstraints = false
                measureLabel.textAlignment = .right
                measureLabel.font = .italicSystemFont(ofSize: 15)
                measureLabel.numberOfLines = 0
                measureLabel.text = measures[i] != nil ? measures[i] : ""
                
                stackView.addArrangedSubviews(ingridientLabel, measureLabel)
                ingridientsStackView.addArrangedSubview(stackView)
            } else { return }
        }
    }
}

extension InfoCocktailViewController {
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: cocktail.strDrinkThumb) { [weak self]
            result in
            switch result {
            case .success(let image):
                self?.imageCocktailView.image = UIImage(data: image)
                self?.activityIndicator.stopAnimating()
                self?.setImageForFavoriteButton()
            case .failure(let error):
                print(error)
            }
        }
    }
}
