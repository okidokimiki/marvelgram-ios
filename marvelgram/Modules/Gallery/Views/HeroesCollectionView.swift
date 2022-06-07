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
    func heroesCollectionView(_ heroesCollectionView: HeroesCollectionView, getHeroViewModelWithIndex index: Int) -> HeroViewModel?
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
        static let minimumItemSpacing: CGFloat = 1
        static let numberOfItemsPerRow: CGFloat = 3
    }
    
    // MARK: - Initilization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureCollectionView() {
        delegate = self
        dataSource = self
        backgroundColor = .none
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: ReuseId.heroCell)
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            let heroCell = cell as? HeroCollectionViewCell,
            let viewModel = dataSourceDelegate?.heroesCollectionView(self, getHeroViewModelWithIndex: indexPath.row)
        else { return }
        
        heroCell.configurePerCellWith(viewModel)
    }
    
}

// MARK: - UICollectionViewDataSource

extension HeroesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let cellsCount = dataSourceDelegate?.heroesCollectionViewCellsCount(self) else { return 0 }
        
        return cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.heroCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HeroesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = LayoutConstants.minimumItemSpacing * (LayoutConstants.numberOfItemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / LayoutConstants.numberOfItemsPerRow
        let itemSize = CGSize(width: widthPerItem, height: widthPerItem)
        
        return itemSize
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
        let itemSpacing = LayoutConstants.minimumItemSpacing
        
        return itemSpacing
    }
}
