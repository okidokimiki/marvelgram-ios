//
//  NetworkService.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

typealias JSONResponseHandler = ((JSONResponse) -> Void)

protocol Networkable {
    func fetchHeroes(completion: @escaping JSONResponseHandler)
    func fetchHeroesConfig(completion: @escaping JSONResponseHandler)
}

final class NetworkService: Networkable {
    // MARK: - Public Properties
    
    static let shared = NetworkService()
    
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    // MARK: - Public Methods
    
    func fetchHeroesConfig(completion: @escaping JSONResponseHandler) {
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
    func fetchHeroes(completion: @escaping JSONResponseHandler) {
        guard let heroesUrl = URL(string: Constants.JsonUrlStrings.upstartsMarvelgram) else {
            completion(.error(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: heroesUrl) { dataOrNil, _, _ in
            guard let fetchedData = dataOrNil else {
                print("failure: couldn't get data by url: \(heroesUrl.path)")
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

private extension NetworkService {
    enum Constants {
        
        enum JsonUrlStrings {
            static let upstartsMarvelgram = "https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json"
        }
    }
}
