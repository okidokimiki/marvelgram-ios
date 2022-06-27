//
//  NetworkManager.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

class NetworkManager {
    // MARK: - Public Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    // MARK: - Public Methods
    
    func fetchHeroesConfig(completion: @escaping ((JSONResponse) -> Void)) {
        guard let heroesUrl = URL(string: Constants.JsonUrlStrings.upstartsMarvelgram) else {
            completion(.error(.invalidURL))
            return
        }

        let downloadTask = session.downloadTask(with: heroesUrl) { urlOrNil, _, _ in
            guard let fetchedConfigUrl = urlOrNil else {
                print("failure: couldn't download file by url: \(heroesUrl.path)")
                completion(.error(.noData))
                return
            }

            completion(.success(fetchedConfigUrl))
        }

        downloadTask.resume()
    }
    
    // Not used, but stored for my "tests"
    func fetchHeroes(completion: @escaping ((JSONResponse) -> Void)) {
        guard let heroesURL = URL(string: Constants.JsonUrlStrings.upstartsMarvelgram) else {
            completion(.error(.invalidURL))
            return
        }

        let task = session.dataTask(with: heroesURL) { dataOrNil, _, _ in
            guard let fetchedData = dataOrNil else {
                print("failure: couldn't get data by url: \(heroesURL.path)")
                completion(.error(.noData))
                return
            }

            do {
                let decodedData = try self.decoder.decode([Hero].self, from: fetchedData)
                completion(.success(decodedData))
            } catch {
                completion(.error(.decodingError))
            }
        }

        task.resume()
    }
}

// MARK: - Constants

private extension NetworkManager {
    enum Constants {
        
        enum JsonUrlStrings {
            static let upstartsMarvelgram = "https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json"
        }
    }
}
