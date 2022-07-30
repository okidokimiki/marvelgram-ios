import UIKit

final class HeroImageViewCell: UICollectionViewCell {
    
    private lazy var heroImageView: UIImageView = {
        makeHeroImageView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(heroImageView)
        activateHeroImageViewConstraints()
    }
    
    // MARK: - Creating Subviews
    
    private func makeHeroImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = AppColor.GlobalColor.cellBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
