import UIKit

protocol HeroesSeleсtingCollectionViewActionDelegate: AnyObject {
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, didSelectHeroWith indexPath: IndexPath)
}

protocol HeroesSeleсtingCollectionViewDataSourceDelegate: AnyObject {
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getCellsCountOf reuseIdentifier: String) -> Int?
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getHeroCellModelWith indexPath: IndexPath) -> HeroCellModel?
}

final class HeroesSeleсtingCollectionView: UICollectionView {
    
    weak var actionDelegate: HeroesSeleсtingCollectionViewActionDelegate?
    weak var dataSourceDelegate: HeroesSeleсtingCollectionViewDataSourceDelegate?
    
    var bottomOffset: CGFloat {
        contentSize.height - bounds.size.height + contentInset.bottom
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
        setupDelegates()
        register(HeroImageViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupDelegates()
        register(HeroImageViewCell.self)
    }
    
    private func setupDelegates() {
        delegate = self
        dataSource = self
    }
    
    private func configure() {
        bounces = false
        backgroundColor = nil
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesSeleсtingCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionDelegate?.heroesSeleсtingCollectionView(self, didSelectHeroWith: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension HeroesSeleсtingCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let heroCellId = HeroImageViewCell.reuseIdentifier
        
        guard let count = dataSourceDelegate?.heroesSeleсtingCollectionView(self, getCellsCountOf: heroCellId) else {
            return .zero
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroCell = collectionView.dequeueCell(cellType: HeroImageViewCell.self, for: indexPath)
        
        if let model = dataSourceDelegate?.heroesSeleсtingCollectionView(self, getHeroCellModelWith: indexPath) {
            heroCell.render(with: model.url)
        }
        
        return heroCell
    }
}
