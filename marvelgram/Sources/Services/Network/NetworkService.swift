//
//  NetworkService.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

final class NetworkService: Networkable {
    // MARK: - Private Properties
    
    private let session: URLSession = {
        let config: URLSessionConfiguration = .default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        
        return URLSession(configuration: config)
    }()
    
    private let decoder = JSONDecoder()
    
    // MARK: - Methods
    
    func fetchConfig<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler) {
        guard let url = URL(string: urlString) else {
            completion(.error(.invalidURL))
            return
        }
        
        let downloadTask = session.downloadTask(with: url) { urlOrNil, responseOrNil, _ in
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
}
