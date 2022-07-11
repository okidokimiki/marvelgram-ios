//
//  CharImageViewCell.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 05.07.2022.
//

import UIKit

class CharImageViewCell: UICollectionViewCell {
    // MARK: - Private Properties
    
    private lazy var characterImageView: ImageLoader = {
        return ImageLoader(frame: .zero)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupViews()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupViews()
        setupAutoLayout()
    }
    
    // MARK: - Methods
    
    func configure(with model: HeroSeleсtingCellModel) {
        characterImageView.loadImage(from: model.url)
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = AppColor.HeroesList.cellBackground
    }
    
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
