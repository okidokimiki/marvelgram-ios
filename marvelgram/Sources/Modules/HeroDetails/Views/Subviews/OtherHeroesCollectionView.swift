import UIKit

protocol OtherHeroesCollectionViewActionDelegate: AnyObject {
}

protocol OtherHeroesCollectionViewDataSourceDelegate: AnyObject {
}

final class OtherHeroesCollectionView: UICollectionView {
    
    weak var actionDelegate: OtherHeroesCollectionViewActionDelegate?
    weak var dataSourceDelegate: OtherHeroesCollectionViewDataSourceDelegate?
    
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
    
    private func configure() {
        bounces = false
        backgroundColor = nil
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupDelegates() {
        delegate = self
        dataSource = self
    }
    
    // MARK: - Constants
    
    enum Constants {
        static let countOfOtherCells: Int = 10
        
        enum FlowLayout {
            static let spacing: CGFloat = 15
        }
    }
}

// MARK: - UICollectionViewDelegate

extension OtherHeroesCollectionView: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource

extension OtherHeroesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Constants.countOfOtherCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let otherHeroCell = collectionView.dequeueCell(cellType: HeroImageViewCell.self, for: indexPath)
        
        return otherHeroCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OtherHeroesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: bounds.height, height: bounds.height)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacing = Constants.FlowLayout.spacing
        
        return cellSpacing
    }
}
