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
        return GalleryView.makeActivityIndicatorView()
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
    
    private func configureView() {
        backgroundColor = UIColor(color: .background)
    }
    
    private func addSubviews() {
        addSubview(heroesCollectionView)
        activateHeroesCollectionViewConstraints()
        
        addSubview(activityIndicatorView)
        activatedActivityIndicatorViewConstraint()
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
    
    static func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        return loader
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
    
    private func activatedActivityIndicatorViewConstraint() {
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
