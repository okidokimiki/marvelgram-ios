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
    
    private lazy var heroImageView: UIImageView = {
        return HeroCollectionViewCell.makeHeroImageView()
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(heroImageView)
        activateHeroImageViewConstraints()
    }
    
    // MARK: - Creating Subviews
    private func configureCollectionViewCell() {
        backgroundColor = UIColor(color: .cellBackground)
    }
    
    static func makeHeroImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    // MARK: - Layout
    
    private func activateHeroImageViewConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
