//
//  HeroSeleсtingCollectionViewCell.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class HeroSeleсtingCollectionViewCell: UICollectionViewCell {
    // MARK: - Private Properties
    
    private lazy var characterImageView: ImageLoader = {
        return ImageLoader(frame: .zero)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupViews()
    }
    
    // MARK: - Methods
    
    func configure(with model: HeroSeleсtingCellModel) {
        characterImageView.loadImage(from: model.url)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = Palette.HeroesList.cellBackground
    }
    
    private func setupViews() {
        setupView(characterImageView)
    }
    
    // MARK: - Override Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activateHeroImageViewConstraints()
    }
    
    // MARK: - Layout
    
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
