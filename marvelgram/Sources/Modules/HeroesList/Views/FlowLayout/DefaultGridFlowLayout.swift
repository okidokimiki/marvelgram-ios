/*    DefaultGrid
 ╔══════╦══════╦══════╗
 ║   0  ║   1  ║   2  ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║   3  ║   4  ║   5  ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║   6  ║   7  ║   8  ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║   9  ║  10  ║  11  ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║  12  ║  13  ║  14  ║
 ║      ║      ║      ║
 ╠══════╬══════╬══════╣
 ║  15  ║  16  ║  17  ║
 ║      ║      ║      ║
 ╚══════╩══════╩══════╝ */

import UIKit

final class DefaultGridFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        let paddingSpace = Constants.minimumInteritemSpacing * CGFloat(Constants.countOfCellsPerRow - 1)
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let itemDimension = availableWidth / CGFloat(Constants.countOfCellsPerRow)
        
        itemSize = CGSize(width: itemDimension, height: itemDimension)
        minimumInteritemSpacing = Constants.minimumInteritemSpacing
        minimumLineSpacing = Constants.minimumLineSpacing
        scrollDirection = .vertical
    }
    
    // MARK: - Constants
    
    enum Constants {
        static let countOfCellsPerRow: CGFloat = 3
        static let minimumLineSpacing: CGFloat = 1
        static let minimumInteritemSpacing: CGFloat = 1
    }
}
