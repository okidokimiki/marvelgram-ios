//
//  HeroesCollectionView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol HeroCollectionViewActionsDelegate: AnyObject {
}

protocol HeroCollectionViewDataSourceDelegate: AnyObject {
}

class HeroesCollectionView: UICollectionView {
    // MARK: - Public Properties
    
    weak var dataSourceDelegate: HeroCollectionViewDataSourceDelegate?
    weak var actionsDelegate: HeroCollectionViewActionsDelegate?
    
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
}

// MARK: - UICollectionViewDataSource

extension HeroesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let cellsCount = 50
        
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
