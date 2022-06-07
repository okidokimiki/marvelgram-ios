//
//  NetworkManager.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    // MARK: - Public Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private enum Constants {
        static let heroesUrlString = "https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json"
    }
    
    // MARK: - Public Methods
    
    func fetchHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        guard let url = URL(string: Constants.heroesUrlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            guard let parseredData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode([Hero].self, from: parseredData)
                completion(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
