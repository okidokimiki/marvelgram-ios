//
//  MainView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class MainView: UIView {
    // MARK: - Public Properties
    
    weak var uiDelegate: MainViewUiDelegate?
    
    // MARK: - Private Properties
    
    private lazy var heroesCollectionView: HeroesSeleсtingCollectionView = {
        return MainView.makeHeroesCollectionView(self, self)
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
    
    static func makeHeroesCollectionView(_ actionsDelegate: HeroesSeleсtingCollectionViewActionsDelegate, _ dataSourceDelegate: HeroesSeleсtingCollectionViewDataSourceDelegate) -> HeroesSeleсtingCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = HeroesSeleсtingCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.actionDelegate = actionsDelegate
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
            heroesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            heroesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
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

extension MainView: HeroesSeleсtingCollectionViewActionsDelegate {
    func heroesSeleсtingCollectionView(_ heroesCollectionView: HeroesSeleсtingCollectionView, didSelectHeroWithIndex index: IndexPath) {
        uiDelegate?.mainView(self, didSelectHeroWithIndex: index)
    }
}

// MARK: - HeroesSeleсtingCollectionViewDataSourceDelegate

extension MainView: HeroesSeleсtingCollectionViewDataSourceDelegate {
    func heroesSeleсtingCollectionView(_ heroesCollectionView: HeroesSeleсtingCollectionView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel? {
        return uiDelegate?.mainView(self, getHeroCellModelWithIndex: index)
    }
    
    func heroesSeleсtingCollectionViewCellsCount(_ heroesCollectionView: HeroesSeleсtingCollectionView) -> Int? {
        return uiDelegate?.mainViewCellsCount(self)
    }
}
