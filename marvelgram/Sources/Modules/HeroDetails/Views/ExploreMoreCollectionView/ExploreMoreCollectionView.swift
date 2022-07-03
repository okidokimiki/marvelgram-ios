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

final class ExploreMoreCollectionView: UICollectionView {
    // MARK: - Public Properties
    
    weak var actionDelegate: ExploreMoreCollectionViewActionsDelegate?
    weak var dataDelegate: ExploreMoreCollectionViewDataSourceDelegate?
    
    // MARK: - Initilization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        delegate = self
        dataSource = self
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        register(ExploreMoreCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate

extension ExploreMoreCollectionView: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource

extension ExploreMoreCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellsCount = Constants.countOfCellsInSection
        
        return cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: ExploreMoreCollectionViewCell.self, for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ExploreMoreCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: bounds.height, height: bounds.height)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacing = Constants.FlowLayout.spacing
        
        return cellSpacing
    }
}

// MARK: - Constants

private extension ExploreMoreCollectionView {
    enum Constants {
        static let countOfCellsInSection = 10
        
        enum FlowLayout {
            static let spacing: CGFloat = 15
        }
    }
}
