//
//  CocktailCell.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 01.11.2023.
//

import UIKit

protocol CellModelRepresentable {
    var viewModel: CocktailCellViewModelProtocol? { get }
}

class CocktailCell: UITableViewCell, CellModelRepresentable {
    var viewModel: CocktailCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }

    private lazy var labelsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }()
    
    private lazy var imageCocktailView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labelsStackView.addArrangedSubviews(mainLabel, secondaryLabel)
        contentView.addSubviews(imageCocktailView, labelsStackView)
        imageCocktailView.addSubview(activityIndicator)
        setConstraints()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCocktailView.image = nil
    }
    
    private func updateView() {
        guard let viewModel = viewModel as? CocktailCellViewModel else { return }
        self.mainLabel.text = viewModel.cocktailName
        self.secondaryLabel.text = viewModel.cocktailAlchohol
//        viewModel.fetchImageCocktail {[unowned self] imageData in
//            self.imageCocktailView.image = UIImage(data: imageData)
//            self.activityIndicator.stopAnimating()
//        }
        if let imageData = viewModel.imageData {
            imageCocktailView.image = UIImage(data: imageData)
            activityIndicator.stopAnimating()
        }
//        self.imageCocktailView.image = UIImage(data: viewModel.imageData ?? Data())
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageCocktailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageCocktailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageCocktailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageCocktailView.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            imageCocktailView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelsStackView.leadingAnchor.constraint(equalTo: imageCocktailView.trailingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageCocktailView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageCocktailView.centerYAnchor)
        ])
    }
}

