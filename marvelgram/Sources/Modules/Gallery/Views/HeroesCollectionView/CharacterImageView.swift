//
//  HeroImageView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class CharacterImageView: UIImageView {
    // MARK: - Private Properties
    
    private let session = URLSession.shared
    private var imageCache = ImageCache.shared
    private var lastImageURLStringUsedToLoadImage: String?
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return CharacterImageView.makeActivityIndicatorView()
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
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
        
        makeAndResumeDataTaskWith(url: url) { [unowned self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    if self.lastImageURLStringUsedToLoadImage == urlString {
                        self.activityIndicatorView.stopAnimating()
                        self.image = image
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        setupView(activityIndicatorView)
    }

    private func makeAndResumeDataTaskWith(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = session.dataTask(with: url) { resumeDataOrNil, _, errorOrNil in
            if let error = errorOrNil {
                print("failed to load image with error: \(error.localizedDescription)")
            }
            
            guard
                let taskImageData = resumeDataOrNil,
                let taskImage = UIImage(data: taskImageData)
            else {
                print("\(String(describing: CharacterImageView.self)) failed to load image from \(url)")
                return
            }
            
            self.imageCache.setObject(taskImage, forKey: url.path as NSString)
            completion(.success(taskImage))
        }
        
        task.resume()
    }
    
    // MARK: - Creating Subviews
    
    static func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView(style: .large)
        loader.startAnimating()
        
        return loader
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activateActivityIndicatorViewConstraints()
    }
    
    private func activateActivityIndicatorViewConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
