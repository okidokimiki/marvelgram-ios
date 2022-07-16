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
    private var lastUrlUsedToLoadImage: URL?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - Methods
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        lastUrlUsedToLoadImage = url
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            image = imageFromCache
            return
        }
        
        resumeDataTask(with: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloadedImage):
                DispatchQueue.main.async {
                    if url == self.lastUrlUsedToLoadImage {
                        self.image = downloadedImage
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        contentMode = .scaleToFill
        backgroundColor = AppColor.HeroesList.cellBackground
    }
    
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
