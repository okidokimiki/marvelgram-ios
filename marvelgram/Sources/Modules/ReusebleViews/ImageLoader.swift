import UIKit

typealias DownloadImageResponseHandler = (Result<UIImage, NetworkError>) -> Void

final class ImageLoader: UIImageView {
    
    private let session = URLSession.shared
    private var imageCache = ImageCache.shared
    private var lastUrlUsedToLoadImage: URL?
    
    private let imageLoaderActivityIndicatorView: UIActivityIndicatorView = {
        RemovebleActivityIndicatorView(frame: .zero)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupUI()
    }
    
    private func configure() {
        contentMode = .scaleToFill
        backgroundColor = AppColor.GlobalColor.cellBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupUI() {
        addSubview(imageLoaderActivityIndicatorView)
        activateHeroImageViewConstraints()
    }
    
    // MARK: - URLSession Request
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageLoaderActivityIndicatorView.startAnimating()
        lastUrlUsedToLoadImage = url
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            imageLoaderActivityIndicatorView.stopAnimating()
            image = imageFromCache
            return
        }
        
        resumeDataTask(with: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloadedImage):
                DispatchQueue.main.async {
                    if url == self.lastUrlUsedToLoadImage {
                        self.imageLoaderActivityIndicatorView.stopAnimating()
                        self.image = downloadedImage
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /* Working with the network should be all in the servers.
     But for asynchronous image downloading I don't know how to do it better */
    
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
    
    // MARK: - AutoLayout
    
    private func activateHeroImageViewConstraints() {
        let subview = imageLoaderActivityIndicatorView
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
