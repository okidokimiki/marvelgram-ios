//
//  HeroImageView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class HeroImageView: UIImageView {
    // MARK: - Private Properties
    
    private var imageCache = ImageCache.shared
    private var imageURLString: String?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
        
    func loadImageWith(urlString: String) {
        image = nil
        imageURLString = urlString
        let imageFromCache = imageCache.object(forKey: urlString as NSString)
        guard imageFromCache == nil else {
            image = imageFromCache
            return
        }
        
        makeAndResumeDataTaskWith(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    if self?.imageURLString == urlString {
                        self?.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func configureImageView() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeAndResumeDataTaskWith(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard
                let taskImageData = data,
                let taskImage = UIImage(data: taskImageData)
            else {
                print("\(String(describing: HeroImageView.self)) failed to load image from \(url)")
                return
            }

            self.imageCache.setObject(taskImage, forKey: urlString as NSString)
            completion(.success(taskImage))
        }

        task.resume()
    }
}
