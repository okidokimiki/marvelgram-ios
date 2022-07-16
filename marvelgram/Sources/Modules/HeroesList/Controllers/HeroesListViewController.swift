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
        setupNavController()
        setupDelegates()
        setupView()
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
        /* These two lines solve such a problem: Navigation Bar changes its background color when scroll the view.
         
         I understand that this is a rather bad decision, because of which new problems may "pop out" in the future.
         If you find a better solution, write to me :) */
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupDelegates() {
        marvelNavBarButton.uiDelegate = self
        search.resultsDelegate = self
        search.uiDelegate = self
    }
    
    private func setupView() {
        let view = HeroesListView()
        view.uiDelegate = self
        self.view = view
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

extension HeroesListViewController: CharSearchControllerUiDelegate {
    func charSearchController(_ charSearchController: CharSearchController, didPresentSearchBarWithText text: String) {
         presenter?.handlePresentingSearchBar(with: text)
    }
    
    func charSearchController(_ charSearchController: CharSearchController, didDismissSearchBarWithText text: String) {
         presenter?.handleDismissingSearchBar(with: text)
    }
}

extension HeroesListViewController: CharSearchControllerResultsDelegate {
    func charSearchController(_ charSearchController: CharSearchController, didUpdateSearchResultsWithText text: String) {
        presenter?.handleUpdatingSearchResults(with: text)
    }
}

// MARK: - NavBarButtonDelegate

extension HeroesListViewController: NavBarButtonItemUiDelegate {
    func navBarButtonItem(_ navBarButtonItem: UIBarButtonItem, didTapNavBarButtonWithType type: NavBarButtonType) {
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
