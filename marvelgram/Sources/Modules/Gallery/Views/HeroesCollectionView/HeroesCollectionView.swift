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

final class HeroesCollectionView: UICollectionView {
    // MARK: - Public Properties
    
    weak var actionsDelegate: HeroesCollectionViewActionsDelegate?
    weak var dataSourceDelegate: HeroesCollectionViewDataSourceDelegate?
    
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
        register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: Constants.ReuseId.heroCell)
    }
}

// MARK: - UICollectionViewDelegate

extension HeroesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            let heroCell = cell as? HeroCollectionViewCell,
            let model = dataSourceDelegate?.heroesCollectionView(self, getHeroCellModelWithIndex: indexPath.row)
        else { return }
        
        heroCell.configure(with: model)
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
        let reuseIdentifier = Constants.ReuseId.heroCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HeroesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.FlowLayout.minimumCellSpacing * CGFloat(Constants.countOfCellsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerCell = availableWidth / CGFloat(Constants.countOfCellsPerRow)
        let cellSize = CGSize(width: widthPerCell, height: widthPerCell)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionSpacing = Constants.FlowLayout.minimumSectionSpacing
        
        return sectionSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellSpacing = Constants.FlowLayout.minimumCellSpacing
        
        return cellSpacing
    }
}

// MARK: - Constants

private extension HeroesCollectionView {
    enum Constants {
        static let countOfCellsPerRow = 3
        
        enum ReuseId {
            static let heroCell = HeroCollectionViewCell.cellID
        }
        
        enum FlowLayout {
            static let minimumSectionSpacing: CGFloat = 1
            static let minimumCellSpacing: CGFloat = 1
        }
    }
}
