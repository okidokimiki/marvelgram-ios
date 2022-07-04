//
//  NetworkService.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

final class NetworkService: Networkable {
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    // MARK: - Methods
    
    func fetchConfig<T: Codable>(of type: T.Type, completion: @escaping JSONResponseHandler) {
        guard let heroesUrl = URL(string: Constants.JsonUrlStrings.upstartsMarvelgram) else {
            completion(.error(.invalidURL))
            return
        }
        
        let downloadTask = session.downloadTask(with: heroesUrl) { urlOrNil, responseOrNil, _ in
            guard let fetchedConfigUrl = urlOrNil else {
                completion(.error(.dataIsNil))
                return
            }
            
            guard
                let httpResponse = responseOrNil as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(.error(.badResponse(responseOrNil)))
                return
            }
            
            completion(.success(fetchedConfigUrl))
        }
        
        downloadTask.resume()
    }
    
    // Not used, but stored for my "tests"
    func fetch<T: Codable>(of type: T.Type, completion: @escaping JSONResponseHandler) {
        guard let heroesUrl = URL(string: Constants.JsonUrlStrings.upstartsMarvelgram) else {
            completion(.error(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: heroesUrl) { dataOrNil, responseOrNil, _ in
            guard let fetchedData = dataOrNil else {
                completion(.error(.dataIsNil))
                return
            }
            
            guard
                let httpResponse = responseOrNil as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(.error(.badResponse(responseOrNil)))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode([T].self, from: fetchedData)
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
