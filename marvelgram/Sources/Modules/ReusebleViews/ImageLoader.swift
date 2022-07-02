//
//  ImageLoader.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 02.07.2022.
//

import UIKit

typealias DownloadImageResponseHandler = (Result<UIImage, NetworkError>) -> Void

class ImageLoader: UIImageView {
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private var imageCache = NSCache<NSString, UIImage>()
    private var lastImageURLStringUsedToLoadImage: String?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func loadImageWith(urlString: String) {
        image = nil
        lastImageURLStringUsedToLoadImage = urlString
        
        let imageFromCache = imageCache.object(forKey: urlString as NSString)
        guard imageFromCache == nil else {
            image = imageFromCache
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        resumeDataTask(with: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    if self.lastImageURLStringUsedToLoadImage == urlString {
                        self.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func resumeDataTask(with url: URL, completion: @escaping DownloadImageResponseHandler) {
        let task = session.dataTask(with: url) { resumeDataOrNil, responseOrNil, _ in
            guard let taskImageData = resumeDataOrNil else {
                completion(.failure(.dataIsNil))
                return
            }
            
            guard
                let httpResponse = responseOrNil as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.badResponse(responseOrNil)))
                return
            }
            
            guard let taskImage = UIImage(data: taskImageData) else {
                completion(.failure(.invalidData))
                return
            }
            
            self.imageCache.setObject(taskImage, forKey: url.path as NSString)
            completion(.success(taskImage))
        }
        
        task.resume()
    }
}
