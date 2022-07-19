//
//  HeroesSeleсtingCollectionView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol HeroesSeleсtingCollectionViewUiDelegate: AnyObject {
    // Actions
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, didSelectHeroWithIndexPath indexPath: IndexPath)
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, willDisplayHeroWithIndexPath indexPath: IndexPath)
    
    // DataSource
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getCellsCountOf reuseIdentifier: String) -> Int?
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getHeroSeleсtCellModelWithIndexPath indexPath: IndexPath) -> HeroCellModel?
}

final class HeroesSeleсtingCollectionView: UICollectionView {
    // MARK: - Properties
    
    weak var uiDelegate: HeroesSeleсtingCollectionViewUiDelegate?
    
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
        bounces = false
        delegate = self
        dataSource = self
        backgroundColor = .none
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(CharImageViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesSeleсtingCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        uiDelegate?.heroesSeleсtingCollectionView(self, didSelectHeroWithIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        uiDelegate?.heroesSeleсtingCollectionView(self, willDisplayHeroWithIndexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension HeroesSeleсtingCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let heroSeleсtCellId = CharImageViewCell.reuseIdentifier
        
        guard let cellsCount = uiDelegate?.heroesSeleсtingCollectionView(self, getCellsCountOf: heroSeleсtCellId) else {
            return .zero
        }
        
        return cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cell
        let heroSeleсtCell = collectionView.dequeueCell(cellType: CharImageViewCell.self, for: indexPath)
        
        // Configure
        if let model = uiDelegate?.heroesSeleсtingCollectionView(self, getHeroSeleсtCellModelWithIndexPath: indexPath) {
            heroSeleсtCell.configure(with: model)
        }
        
        return heroSeleсtCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HeroesSeleсtingCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.FlowLayout.minimumCellSpacing * CGFloat(Constants.countOfCellsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerCell = availableWidth / CGFloat(Constants.countOfCellsPerRow)
        let cellSize = CGSize(width: widthPerCell, height: widthPerCell)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionSpacing = Constants.FlowLayout.minimumSectionSpacing
        
        return sectionSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacing = Constants.FlowLayout.minimumCellSpacing
        
        return cellSpacing
    }
}

// MARK: - Constants

private extension HeroesSeleсtingCollectionView {
    enum Constants {
        static let countOfCellsPerRow = 3
        
        enum FlowLayout {
            static let minimumSectionSpacing: CGFloat = 1
            static let minimumCellSpacing: CGFloat = 1
        }
    }
}
