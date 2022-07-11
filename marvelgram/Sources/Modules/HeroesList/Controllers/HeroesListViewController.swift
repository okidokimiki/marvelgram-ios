//
//  HeroesListViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class HeroesListViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: HeroesListViewOutput?
    
    // MARK: - Private Properties
    
    private var heroesListView: HeroesListView {
        guard let castedView = view as? HeroesListView else {
            fatalError("TypeCasting Error: presenterView must be \(HeroesListView.self)")
        }
        
        return castedView
    }
    
    private lazy var search: CharSearchController = {
        return CharSearchController(searchResultsController: nil)
    }()
    
    private lazy var marvelNavBarButton: MarvelBarButtonItem = {
        return MarvelBarButtonItem()
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = HeroesListView()
        marvelNavBarButton.uiDelegate = self
        search.resultsDelegate = self
        view.uiDelegate = self
        setupNavController()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.handleDidLoadView()
    }
    
    // MARK: - Private Methods
    
    private func setupNavController() {
        // Search
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        // Button
        navigationItem.leftBarButtonItem = marvelNavBarButton
        // NavigationController
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = AppColor.GlobalColor.background
        navigationController?.navigationBar.backgroundColor = AppColor.GlobalColor.background
    }
}

// MARK: - UiDelegate

extension HeroesListViewController: HeroesListViewUiDelegate {
    // Actions
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndex index: Int) {
        presenter?.handleSelectingHeroCell(with: index)
    }
    
    // DataSource
    func heroesListView(_ heroesListView: HeroesListView, getCellsCountOf reuseIdentifier: String) -> Int? {
        return presenter?.getHeroSelсtCellsCount()
    }
    
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel? {
        return presenter?.getHeroSelсtCellModel(with: index)
    }
}

// MARK: - SearchDelegate

extension HeroesListViewController: CharSearchControllerResultsDelegate {
    func charSearchController(_ charSearchController: CharSearchController, didUpdateSearchResultsWithText text: String) {
        // Actions
        presenter?.handleUpdatingSearchResults(with: text)
    }
}

// MARK: - NavBarButtonDelegate

extension HeroesListViewController: NavBarButtonItemUiDelegate {
    func navBarButtonItem(_ navBarButtonItem: UIBarButtonItem, didTapNavBarButtonWithType type: NavBarButtonType) {
        // Actions
        presenter?.handleTappingNavBarButton(with: type)
    }
}

// MARK: - ViewInput

extension HeroesListViewController: HeroesListViewInput {
    func reloadHeroesSeleсtingCollectionView() {
        heroesListView.reloadHeroesSeleсtingCollectionView()
    }
    
    func showActivityIndicator(_ show: Bool) {
        heroesListView.showActivityIndicator(show)
    }
    
    func moveUpCell(with indexPath: IndexPath) {
        heroesListView.moveUpCell(with: indexPath)
    }
}
