//
//  OtherCharactersCollectionView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 14.06.2022.
//

import UIKit

protocol OtherCharactersCollectionViewActionsDelegate: AnyObject {
}

protocol OtherCharactersCollectionViewDataSourceDelegate: AnyObject {
    func otherCharCollectionView(_ otherCharCollectionView: OtherCharactersCollectionView, getCellsCountOf reuseIdentifier: String) -> Int?
    func otherCharCollectionView(_ otherCharCollectionView: OtherCharactersCollectionView, getOtherCharCellModelWithIndex index: Int) -> HeroSeleсtingCellModel?
}

final class OtherCharactersCollectionView: UICollectionView {
    // MARK: - Properties
    
    weak var actionsDelegate: OtherCharactersCollectionViewActionsDelegate?
    weak var dataSourceDelegate: OtherCharactersCollectionViewDataSourceDelegate?
    
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
        register(CharImageViewCell.self)
    }
}

// MARK: - UICollectionViewDelegate

extension OtherCharactersCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let otherCharCell = cell as? CharImageViewCell else {
            fatalError("TypeCasting Error: cell must be \(CharImageViewCell.self)")
        }
        
        if let model = dataSourceDelegate?.otherCharCollectionView(self, getOtherCharCellModelWithIndex: indexPath.row) {
            otherCharCell.configure(with: model)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension OtherCharactersCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let otherCharCellId = CharImageViewCell.reuseIdentifier
        guard let cellsCount = dataSourceDelegate?.otherCharCollectionView(self, getCellsCountOf: otherCharCellId) else {
            return .zero
        }
        
        return cellsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: CharImageViewCell.self, for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OtherCharactersCollectionView: UICollectionViewDelegateFlowLayout {
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

private extension OtherCharactersCollectionView {
    enum Constants {
        static let countOfCellsInSection = 10
        
        enum FlowLayout {
            static let spacing: CGFloat = 15
        }
    }
}
