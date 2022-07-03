//
//  HeroesListView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class HeroesListView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: HeroesListViewUiDelegate?
    
    // MARK: - Private Properties
    
    private lazy var heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView = {
        return HeroesListView.makeHeroesSeleсtingCollectionView(self, self)
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
    
    func reloadHeroesSeleсtingCollectionView() {
        heroesSeleсtingCollectionView.reloadData()
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
        backgroundColor = Palette.GlobalColor.backgroundPrimary
    }
    
    private func setupViews() {
        setupView(heroesSeleсtingCollectionView)
        setupView(activityIndicatorView)
    }
    
    // MARK: - Creating Subviews
    
    static func makeHeroesSeleсtingCollectionView(_ actionsDelegate: HeroesSeleсtingCollectionViewActionsDelegate, _ dataSourceDelegate: HeroesSeleсtingCollectionViewDataSourceDelegate) -> HeroesSeleсtingCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = HeroesSeleсtingCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.actionsDelegate = actionsDelegate
        collectionView.dataDelegate = dataSourceDelegate
        
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
            heroesSeleсtingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesSeleсtingCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            heroesSeleсtingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesSeleсtingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func activateActivityIndicatorViewConstraint() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - HeroesSeleсtingCollectionViewActionsDelegate

extension HeroesListView: HeroesSeleсtingCollectionViewActionsDelegate {
    func heroesSeleсtingCollectionView(_ heroesCollectionView: HeroesSeleсtingCollectionView, didSelectHeroWithIndex index: IndexPath) {
        uiDelegate?.heroesListView(self, didSelectHeroWithIndex: index)
    }
}

// MARK: - HeroesSeleсtingCollectionViewDataSourceDelegate

extension HeroesListView: HeroesSeleсtingCollectionViewDataSourceDelegate {
    func heroesSeleсtingCollectionView(_ heroesCollectionView: HeroesSeleсtingCollectionView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel? {
        return uiDelegate?.heroesListView(self, getHeroCellModelWithIndex: index)
    }
    
    func heroesSeleсtingCollectionViewCellsCount(_ heroesCollectionView: HeroesSeleсtingCollectionView) -> Int? {
        return uiDelegate?.heroesListViewCellsCount(self)
    }
}
