//
//  HeroesCollectionView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol HeroesCollectionViewActionsDelegate: AnyObject {
}

protocol HeroesCollectionViewDataSourceDelegate: AnyObject {
    func heroesCollectionView(_ heroesCollectionView: HeroesCollectionView, getHeroCellModelWithIndex index: Int) -> HeroCellModel?
    func heroesCollectionViewCellsCount(_ heroesCollectionView: HeroesCollectionView) -> Int?
}

class HeroesCollectionView: UICollectionView {
    // MARK: - Public Properties
    
    weak var actionsDelegate: HeroesCollectionViewActionsDelegate?
    weak var dataSourceDelegate: HeroesCollectionViewDataSourceDelegate?
    
    // MARK: - Private Properties
    
    private enum ReuseId {
        static let heroCell = HeroCollectionViewCell.cellID
    }
    
    private enum LayoutConstants {
        static let minimumSectionSpacing: CGFloat = 1
        static let minimumCellSpacing: CGFloat = 1
        static let numberOfCellsPerRow: Int = 3
    }
    
    // MARK: - Initilization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        delegate = self
        dataSource = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: ReuseId.heroCell)
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            let heroCell = cell as? HeroCollectionViewCell,
            let heroModel = dataSourceDelegate?.heroesCollectionView(self, getHeroCellModelWithIndex: indexPath.row)
        else { return }
        
        heroCell.configure(with: heroModel)
    }
}

// MARK: - UICollectionViewDataSource

extension HeroesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let heroCellsCount = dataSourceDelegate?.heroesCollectionViewCellsCount(self) else { return 0 }
        
        return heroCellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.heroCell, for: indexPath)
        
        return heroCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HeroesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = LayoutConstants.minimumCellSpacing * CGFloat(LayoutConstants.numberOfCellsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerCell = availableWidth / CGFloat(LayoutConstants.numberOfCellsPerRow)
        let cellSize = CGSize(width: widthPerCell, height: widthPerCell)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionSpacing = LayoutConstants.minimumSectionSpacing
        
        return sectionSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacing = LayoutConstants.minimumCellSpacing
        
        return cellSpacing
    }
}
