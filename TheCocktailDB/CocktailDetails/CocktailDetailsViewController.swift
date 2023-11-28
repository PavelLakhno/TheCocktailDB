//
//  CocktailDetailsViewController.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 30.10.2023.
//

import UIKit

protocol CocktailDetailsDisplayLogic: AnyObject {
    func displayCocktailDetails(viewModel: CocktailDetails.ShowDetails.ViewModel)
    func displayFavoriteButtonStatus(viewModel: CocktailDetails.SetFavoriteStatus.ViewModel)
}

class CocktailDetailsViewController: UIViewController {
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
    
//    var cocktail: Cocktail!
    var interactor: CocktailDetailsBusinessLogic?
    var router: (CocktailDetailsRoutingLogic & CocktailDetailsDataPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        CocktailDetailsConfigurator.shared.configure(with: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        CocktailDetailsConfigurator.shared.configure(with: self)
    }

    // MARK: ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(imageCocktailView, favoriteButton, instructionLabel, ingridientsStackView)
        view.backgroundColor = .white
        imageCocktailView.addSubview(activityIndicator)
        setupConstraints()
        passRequest()
    }

    // MARK: - Actions
    @objc func toggleFavorite(_ sender: UIButton) {
        interactor?.setFavoriteStatus()
    }
    
    private func passRequest() {
        interactor?.provideCocktailDetails()
    }
    
    // MARK: - Private Methods
    
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
}

// MARK: - CourseDetailsDisplayLogic
extension CocktailDetailsViewController: CocktailDetailsDisplayLogic {
    func displayCocktailDetails(viewModel: CocktailDetails.ShowDetails.ViewModel) {
        instructionLabel.text = viewModel.cocktailInstruction
        displayCocktailComposition(viewModel: viewModel)
        imageCocktailView.image = UIImage(data: viewModel.imageURL)
        favoriteButton.tintColor = viewModel.isFavorite ? .red : .white
    }
    
    private  func displayCocktailComposition(viewModel: CocktailDetails.ShowDetails.ViewModel){
        let ingridients = viewModel.ingridients
        let measures = viewModel.measures
        
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
                ingridientLabel.font = .monospacedDigitSystemFont(ofSize: 15, weight: .medium)
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

    func displayFavoriteButtonStatus(viewModel: CocktailDetails.SetFavoriteStatus.ViewModel) {
        favoriteButton.tintColor = viewModel.isFavorite ? .red : .white
    }
}
