//
//  ExploreMoreCollectionViewCell.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 14.06.2022.
//

import UIKit

final class ExploreMoreCollectionViewCell: UICollectionViewCell {
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = Palette.GlobalColor.white
    }
}
