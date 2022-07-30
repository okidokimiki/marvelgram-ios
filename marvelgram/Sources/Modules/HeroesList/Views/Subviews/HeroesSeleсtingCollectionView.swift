import UIKit

protocol HeroesSeleсtingCollectionViewActionDelegate: AnyObject {
}

protocol HeroesSeleсtingCollectionViewDataSourceDelegate: AnyObject {
}

final class HeroesSeleсtingCollectionView: UICollectionView {
    
    weak var actionDelegate: HeroesSeleсtingCollectionViewActionDelegate?
    weak var dataSourceDelegate: HeroesSeleсtingCollectionViewDataSourceDelegate?
    
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
    
    // MARK: - Constants
    
    enum Constants {
        static let countOfHeroCells: Int = 50
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesSeleсtingCollectionView: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource

extension HeroesSeleсtingCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Constants.countOfHeroCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroCell = collectionView.dequeueCell(cellType: HeroImageViewCell.self, for: indexPath)
        
        return heroCell
    }
}
