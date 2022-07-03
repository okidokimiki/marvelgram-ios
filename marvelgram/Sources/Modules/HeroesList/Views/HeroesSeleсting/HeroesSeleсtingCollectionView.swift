//
//  HeroesSeleсtingCollectionView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol HeroesSeleсtingCollectionViewActionsDelegate: AnyObject {
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, didSelectHeroWithIndex index: IndexPath)
}

protocol HeroesSeleсtingCollectionViewDataSourceDelegate: AnyObject {
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel?
    func heroesSeleсtingCollectionViewCellsCount(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView) -> Int?
}

final class HeroesSeleсtingCollectionView: UICollectionView {
    // MARK: - Public Properties
    
    weak var actionsDelegate: HeroesSeleсtingCollectionViewActionsDelegate?
    weak var dataDelegate: HeroesSeleсtingCollectionViewDataSourceDelegate?
    
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
        backgroundColor = .none
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(HeroSeleсtingCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesSeleсtingCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionsDelegate?.heroesSeleсtingCollectionView(self, didSelectHeroWithIndex: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            let heroCell = cell as? HeroSeleсtingCollectionViewCell,
            let model = dataDelegate?.heroesSeleсtingCollectionView(self, getHeroCellModelWithIndex: indexPath.row)
        else { return }
        
        heroCell.configure(with: model)
    }
}

// MARK: - UICollectionViewDataSource

extension HeroesSeleсtingCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellsCount = dataDelegate?.heroesSeleсtingCollectionViewCellsCount(self) else { return 0 }
        
        return cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroCell = collectionView.dequeueCell(cellType: HeroSeleсtingCollectionViewCell.self, for: indexPath)
        
        return heroCell
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
