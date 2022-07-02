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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = Palette.GlobalColor.cellBackground
    }
    
    private func setupViews() {
        setupView(characterImageView)
    }
    
    // MARK: - Public Methods
    
    func configure(with model: HeroSeleсtingCellModel) {
        characterImageView.loadImage(from: model.url)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activateHeroImageViewConstraints()
    }
    
    private func activateHeroImageViewConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
