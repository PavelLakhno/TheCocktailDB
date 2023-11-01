//
//  ImageManager.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 01.11.2023.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
