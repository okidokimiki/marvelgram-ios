//
//  GalleryView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class GalleryView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: GalleryViewUiDelegate?
    
    // MARK: - Private Properties

    private lazy var heroesCollectionView: HeroesCollectionView = {
        return GalleryView.makeHeroesCollectionView(self, self)
    }()
    
    // MARK: - Initilization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = UIColor(color: .background)
    }
    
    private func addSubviews() {
        addSubview(heroesCollectionView)
        activateHeroesCollectionViewConstraints()
    }
    
    // MARK: - Creating Subviews

    static func makeHeroesCollectionView(_ actionsDelegate: HeroCollectionViewActionsDelegate, _ dataSourceDelegate: HeroCollectionViewDataSourceDelegate) -> HeroesCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = HeroesCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.actionsDelegate = actionsDelegate
        collectionView.dataSourceDelegate = dataSourceDelegate

        return collectionView
    }
    
    // MARK: - Layout
    
    private func activateHeroesCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            heroesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            heroesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            heroesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            heroesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - HeroCollectionViewActionsDelegate

extension GalleryView: HeroCollectionViewActionsDelegate {
}

// MARK: - HeroCollectionViewDataSourceDelegate

extension GalleryView: HeroCollectionViewDataSourceDelegate {
}
