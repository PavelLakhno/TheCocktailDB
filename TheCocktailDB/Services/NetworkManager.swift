//
//  NetworkManager.swift
//  TheCocktailDB
//
//  Created by Pavel Lakhno on 01.11.2023.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

enum Link: String {
    case cocktailsURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCocktails(from url: String, completion: @escaping(Result<Drinks, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let type = try JSONDecoder().decode(Drinks.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
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
    
    func fetchImageData(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        
        return imageData
    }
    
}
