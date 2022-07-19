//
//  CharImageViewCell.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 05.07.2022.
//

import UIKit

// FIXME: try prepare cell`s image
/*
 override func prepareForReuse() {
    image = nil
 }
*/
class CharImageViewCell: UICollectionViewCell {
    // MARK: - Private Properties
    
    private lazy var characterImageView: ImageLoader = {
        return ImageLoader(frame: .zero)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupAutoLayout()
    }
    
    // MARK: - Methods
    
    func configure(with model: HeroCellModel) {
        characterImageView.loadImage(from: model.url)
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        setupView(characterImageView)
    }
    
    private func setupAutoLayout() {
        activateHeroImageViewConstraints()
    }
    
    // MARK: - AutoLayout
    
    private func activateHeroImageViewConstraints() {
        let subview = characterImageView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
