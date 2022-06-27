//
//  GalleryViewCollectionViewCell.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Properties
    
    static let cellID = String(describing: HeroCollectionViewCell.self)
    
    // MARK: - Private Properties
    
    private lazy var heroImageView: CharacterImageView = {
        return CharacterImageView(frame: .zero)
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
        backgroundColor = UIColor(assets: .accent1)
    }
    
    private func setupViews() {
        setupView(heroImageView)
    }
    
    // MARK: - Public Methods
    
    func configure(with model: HeroCellModel) {
        heroImageView.loadImageWith(urlString: model.url)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activateHeroImageViewConstraints()
    }
    
    private func activateHeroImageViewConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
