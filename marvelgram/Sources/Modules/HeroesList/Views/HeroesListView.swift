//
//  HeroesListView.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol HeroesListViewUiDelegate: AnyObject {
    // Actions
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndex index: Int)
    func heroesListView(_ heroesListView: HeroesListView, willDisplayHeroWithIndex index: Int)
    
    // DataSource
    func heroesListView(_ heroesListView: HeroesListView, getCellsCountOf reuseIdentifier: String) -> Int?
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndex index: Int) -> HeroCellModel?
}

final class HeroesListView: UIView {
    // MARK: - Properties
    
    weak var uiDelegate: HeroesListViewUiDelegate?
    
    // MARK: - Private Properties
    
    private lazy var heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView = {
        return makeHeroesSeleсtingCollectionView(uiDelegate: self)
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
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

    func moveUpCell(with indexPath: IndexPath) {
        print(#function) // FIXME: Delete
        heroesSeleсtingCollectionView.performBatchUpdates {
            self.heroesSeleсtingCollectionView.moveItem(at: indexPath, to: .zero)
        }
    }
    
    func setAlphaForCell(with indexPath: IndexPath, alpha: HeroCellAlpha) {
        heroesSeleсtingCollectionView.cellForItem(at: indexPath)?.alpha = CGFloat(alpha.value)
    }
    
    func setAlphaForEachVisibleCells(alpha: HeroCellAlpha) {
        heroesSeleсtingCollectionView.visibleCells.forEach { $0.alpha = CGFloat(alpha.value) }
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        backgroundColor = AppColor.GlobalColor.background
    }
    
    private func setupViews() {
        setupView(heroesSeleсtingCollectionView)
        setupView(activityIndicatorView)
    }
    
    private func setupAutoLayout() {
        activateHeroesCollectionViewConstraints()
        activateActivityIndicatorViewConstraint()
    }
    
    // MARK: - Creating Subviews
    
    private func makeHeroesSeleсtingCollectionView(uiDelegate: HeroesSeleсtingCollectionViewUiDelegate) -> HeroesSeleсtingCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = HeroesSeleсtingCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.uiDelegate = uiDelegate
        
        return collectionView
    }
    
    // MARK: - AutoLayout
    
    private func activateHeroesCollectionViewConstraints() {
        let subview = heroesSeleсtingCollectionView
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func activateActivityIndicatorViewConstraint() {
        let subview = activityIndicatorView
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - UiDelegate

extension HeroesListView: HeroesSeleсtingCollectionViewUiDelegate {
    // Actions
    func heroesSeleсtingCollectionView(_ heroesCollectionView: HeroesSeleсtingCollectionView, didSelectHeroWithIndex index: Int) {
        uiDelegate?.heroesListView(self, didSelectHeroWithIndex: index)
    }
    
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, willDisplayHeroWithIndex index: Int) {
        uiDelegate?.heroesListView(self, willDisplayHeroWithIndex: index)
    }
    
    // DataSource
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getHeroSeleсtCellModelWithIndex index: Int) -> HeroCellModel? {
        return uiDelegate?.heroesListView(self, getHeroCellModelWithIndex: index)
    }
    
    func heroesSeleсtingCollectionView(_ heroesSeleсtingCollectionView: HeroesSeleсtingCollectionView, getCellsCountOf reuseIdentifier: String) -> Int? {
        return uiDelegate?.heroesListView(self, getCellsCountOf: reuseIdentifier)
    }
}
