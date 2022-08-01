import Foundation

final class NetworkService: Networkable {
    
    private let session: URLSession = {
        let config: URLSessionConfiguration = .default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        
        return URLSession(configuration: config)
    }()
    
    private let decoder = JSONDecoder()
    
    func fetchConfig<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let downloadTask = session.downloadTask(with: url) { url, response, _ in
            guard let fetchedConfigUrl = url else {
                completion(.failure(.dataIsNil))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.badResponse(response)))
                return
            }
            
            completion(.success(fetchedConfigUrl))
        }
        
        downloadTask.resume()
    }
    
    func fetch<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, _ in
            guard let fetchedData = data else {
                completion(.failure(.dataIsNil))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.badResponse(response)))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode(T.self, from: fetchedData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
}
