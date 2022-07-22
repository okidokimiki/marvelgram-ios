//
//  DefaultGridFlowLayout.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 22.07.2022.
//

/* DefaultGrid
 ╔══════╦══════╦══════╗
 ║      ║      ║      ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║      ║      ║      ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║      ║      ║      ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║      ║      ║      ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║      ║      ║      ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║      ║      ║      ║
 ║      ║      ║      ║
 ╚══════╩══════╩══════╝
 */

import UIKit

final class DefaultGridFlowLayout: UICollectionViewFlowLayout {
    // MARK: - Initilization
    
    override init() {
        super.init()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        let paddingSpace = Constants.minimumInteritemSpacing * CGFloat(Constants.countOfCellsPerRow - 1)
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let itemDimension = availableWidth / CGFloat(Constants.countOfCellsPerRow)
        
        itemSize = CGSize(width: itemDimension, height: itemDimension)
        minimumInteritemSpacing = Constants.minimumInteritemSpacing
        minimumLineSpacing = Constants.minimumLineSpacing
        scrollDirection = .vertical
    }
}

// MARK: - Constants

private extension DefaultGridFlowLayout {
    enum Constants {
        static let countOfCellsPerRow: CGFloat = 3
        static let minimumLineSpacing: CGFloat = 1
        static let minimumInteritemSpacing: CGFloat = 1
    }
}
