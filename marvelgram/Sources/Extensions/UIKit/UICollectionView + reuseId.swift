//
//  UICollectionView + reuseId.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 01.07.2022.
//

import UIKit

extension UICollectionReusableView: ReuseIdentifiable {
}

extension UICollectionView {
    // MARK: - Methods
    
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Can't dequeue \(String(describing: T.self))")
        }
        
        return cell
    }
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
}
