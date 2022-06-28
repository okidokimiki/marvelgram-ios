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
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
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
    
    // MARK: - Public Methods
    
    func reloadHeroesCollectionView() {
        heroesCollectionView.reloadData()
    }
    
    func showActivityIndicator(_ show: Bool) {
        if show {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = UIColor(assets: .background)
    }
    
    private func setupViews() {
        setupView(heroesCollectionView)
        setupView(activityIndicatorView)
    }
    
    // MARK: - Creating Subviews
    
    static func makeHeroesCollectionView(_ actionsDelegate: HeroesCollectionViewActionsDelegate, _ dataSourceDelegate: HeroesCollectionViewDataSourceDelegate) -> HeroesCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = HeroesCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.actionsDelegate = actionsDelegate
        collectionView.dataSourceDelegate = dataSourceDelegate
        
        return collectionView
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activateHeroesCollectionViewConstraints()
        activateActivityIndicatorViewConstraint()
    }
    
    private func activateHeroesCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            heroesCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            heroesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            heroesCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            heroesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func activateActivityIndicatorViewConstraint() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - HeroesCollectionViewActionsDelegate

extension GalleryView: HeroesCollectionViewActionsDelegate {
}

// MARK: - HeroesCollectionViewDataSourceDelegate

extension GalleryView: HeroesCollectionViewDataSourceDelegate {
    func heroesCollectionView(_ heroesCollectionView: HeroesCollectionView, getHeroCellModelWithIndex index: Int) -> HeroCellModel? {
        return uiDelegate?.galleryView(self, getHeroCellModelWithIndex: index)
    }
    
    func heroesCollectionViewCellsCount(_ heroesCollectionView: HeroesCollectionView) -> Int? {
        return uiDelegate?.galleryViewCellsCount(self)
    }
}
