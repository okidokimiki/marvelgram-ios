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
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getCellsCountOf reuseIdentifier: String) -> Int?
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getHeroSelсtCellModelWithIndex index: Int) -> HeroSeleсtingCellModel?
}

final class HeroesSeleсtingCollectionView: UICollectionView {
    // MARK: - Properties
    
    weak var actionsDelegate: HeroesSeleсtingCollectionViewActionsDelegate?
    weak var dataDelegate: HeroesSeleсtingCollectionViewDataSourceDelegate?
    
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
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        register(CharImageViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesSeleсtingCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionsDelegate?.heroesSeleсtingCollectionView(self, didSelectHeroWithIndex: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let heroeSelсt = cell as? CharImageViewCell else {
            fatalError("TypeCasting Error: cell must be \(CharImageViewCell.self)")
        }

        if let model = dataDelegate?.heroesSeleсtingCollectionView(self, getHeroSelсtCellModelWithIndex: indexPath.row) {
            heroeSelсt.configure(with: model)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HeroesSeleсtingCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let heroSelсtCellId = CharImageViewCell.reuseIdentifier
        
        guard let cellsCount = dataDelegate?.heroesSeleсtingCollectionView(self, getCellsCountOf: heroSelсtCellId) else {
            return .zero
        }
        
        return cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let heroSelсtCell = collectionView.dequeueCell(cellType: CharImageViewCell.self, for: indexPath)
        
        return heroSelсtCell
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
