import UIKit

protocol OtherHeroesCollectionViewActionDelegate: AnyObject {
    func otherHeroesCollectionView(_ otherHeroesCollectionView: OtherHeroesCollectionView, didSelectHeroCellWithIndexPath indexPath: IndexPath)
}

protocol OtherHeroesCollectionViewDataSourceDelegate: AnyObject {
    func otherHeroesCollectionView(_ otherHeroesCollectionView: OtherHeroesCollectionView, getCellsCountOf reuseIdentifier: String) -> Int?
    func otherHeroesCollectionView(_ otherHeroesCollectionView: OtherHeroesCollectionView, getOtherHeroCellModelWithIndexPath indexPath: IndexPath) -> HeroCellModel?
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionDelegate?.otherHeroesCollectionView(self, didSelectHeroCellWithIndexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension OtherHeroesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let otherHeroCellId = HeroImageViewCell.reuseIdentifier
        guard let count = dataSourceDelegate?.otherHeroesCollectionView(self, getCellsCountOf: otherHeroCellId) else {
            return .zero
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let otherHeroCell = collectionView.dequeueCell(cellType: HeroImageViewCell.self, for: indexPath)
        
        if let model = dataSourceDelegate?.otherHeroesCollectionView(self, getOtherHeroCellModelWithIndexPath: indexPath) {
            otherHeroCell.render(with: model.url)
        }
        
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
