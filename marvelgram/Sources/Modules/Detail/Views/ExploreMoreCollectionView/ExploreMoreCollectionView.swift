//
//  ExploreMoreCollectionView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 14.06.2022.
//

import UIKit

protocol ExploreMoreCollectionViewActionsDelegate: AnyObject {
}

protocol ExploreMoreCollectionViewDataSourceDelegate: AnyObject {
}

class ExploreMoreCollectionView: UICollectionView {
    // MARK: - Public Properties
    
    weak var actionsDelegate: ExploreMoreCollectionViewActionsDelegate?
    weak var dataSourceDelegate: ExploreMoreCollectionViewDataSourceDelegate?
    
    // MARK: - Private Properties
    
    private enum ReuseId {
        static let explMoreCell = ExploreMoreCollectionViewCell.cellID
    }
    
    private enum LayoutConstants {
        static let numberOfCellsPerRow: Int = 10
        static let padding: CGFloat = 15
    }
    // MARK: - Initilization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        delegate = self
        dataSource = self
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        register(ExploreMoreCollectionViewCell.self, forCellWithReuseIdentifier: ReuseId.explMoreCell)
    }
}

// MARK: - UICollectionViewDelegate

extension ExploreMoreCollectionView: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource

extension ExploreMoreCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let explMoreCellsCount = LayoutConstants.numberOfCellsPerRow
        
        return explMoreCellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseId.explMoreCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ExploreMoreCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: bounds.height, height: bounds.height)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacing = LayoutConstants.padding
        
        return cellSpacing
    }
}
