//
//  HeroesListViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class HeroesListViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: HeroesListViewOutput?
    
    // MARK: - Private Properties
    
    private lazy var marvelButton = MarvelBarButtonItem()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = HeroesListView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.handleDidAppearingView()
    }
    
    // MARK: - Private Methods
    
    private func setupNavController() {
        navigationItem.leftBarButtonItem = marvelButton
    }
}

// MARK: - UiDelegate

extension HeroesListViewController: HeroesListViewUiDelegate {
    // Actions
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndex index: IndexPath) {
        presenter?.handleSelectingHeroCell(with: index.row)
    }
    
    // DataSource
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel? {
        return presenter?.getHeroCellModel(with: index)
    }
    
    func heroesListViewCellsCount(_ heroesListView: HeroesListView) -> Int? {
        return presenter?.getHeroCellModelsCount()
    }
}

// MARK: - ViewInput

extension HeroesListViewController: HeroesListViewInput {
    func reloadHeroesCollectionView() {
        guard let heroesListView = view as? HeroesListView else { return }
        heroesListView.reloadHeroesCollectionView()
    }
    
    func showActivityIndicator(_ show: Bool) {
        guard let heroesListView = view as? HeroesListView else { return }
        heroesListView.showActivityIndicator(show)
    }
}
