import UIKit

final class HeroImageViewCell: UICollectionViewCell {
    
    private lazy var heroImageView: ImageLoader = {
        ImageLoader(frame: .zero)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        heroImageView.image = nil
    }
    
    private func setupUI() {
        addSubview(heroImageView)
        activateHeroImageViewConstraints()
    }
    
    func render(with urlString: String) {
        heroImageView.loadImage(from: urlString)
    }
    
    // MARK: - AutoLayout
    
    private func activateHeroImageViewConstraints() {
        let subview = heroImageView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
