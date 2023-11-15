//
//  UIView+ext.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 12.11.2023.
//

import UIKit

// MARK: UIView + extention
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {(addSubview($0))}
    }
}

// MARK: UIStackView + extention
extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {(addArrangedSubview($0))}
    }
}
