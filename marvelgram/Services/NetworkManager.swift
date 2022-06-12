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
    
    func fetchHeroesConfig(completion: @escaping (Result<URL, NetworkError>) -> Void) {
        guard let heroesURL = URL(string: Constants.heroesUrlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let downloadTask = session.downloadTask(with: heroesURL) { urlOrNil, _, _ in
            guard let fileURL = urlOrNil else {
                print("failure: couldn't download file by url: \(heroesURL.path)")
                completion(.failure(.noData))
                return
            }
            
            completion(.success(fileURL))
        }
        
        downloadTask.resume()
    }
    
    func fetchHeroes(completion: @escaping (Result<[Hero], NetworkError>) -> Void) {
        guard let heroesURL = URL(string: Constants.heroesUrlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: heroesURL) { dataOrNil, _, _ in
            guard let fetchedData = dataOrNil else {
                print("failure: couldn't get data by url: \(heroesURL.path)")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode([Hero].self, from: fetchedData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
