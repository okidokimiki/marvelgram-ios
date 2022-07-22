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
    
    var bottomOffset: CGFloat {
        return contentSize.height - bounds.size.height + contentInset.bottom
    }
    
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
