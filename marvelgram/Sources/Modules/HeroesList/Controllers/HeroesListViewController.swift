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
    
    private lazy var charNavBarSearch: CharSearchController = {
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
        // SearchBar
        navigationItem.searchController = charNavBarSearch
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // ButtonBar
        navigationItem.leftBarButtonItem = marvelNavBarButton
        
        // NavigationBar
        /* These two lines solve such a problem: Navigation Bar changes its background color when scroll the view.
         
         I understand that this is a rather bad decision, because of which new problems may "pop out" in the future.
         If you find a better solution, write to me :) */
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupDelegates() {
        marvelNavBarButton.uiDelegate = self
        charNavBarSearch.resultsDelegate = self
        charNavBarSearch.uiDelegate = self
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
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndexPath indexPath: IndexPath) {
        presenter?.handleDidSelectingHeroCell(with: indexPath)
    }
    
    func heroesListView(_ heroesListView: HeroesListView, willDisplayHeroWithIndexPath indexPath: IndexPath) {
        presenter?.handleWillDisplayingHeroCell(with: indexPath)
    }
    
    func heroesListView(_ heroesListView: HeroesListView, didMoveUpHeroWithAnimationResult result: Bool) {
        presenter?.handleDidShowingAnimationHeroCell(with: result)
    }
    
    // DataSource
    func heroesListView(_ heroesListView: HeroesListView, getCellsCountOf reuseIdentifier: String) -> Int? {
        return presenter?.getHeroSeleсtCellsCount()
    }
    
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndexPath indexPath: IndexPath) -> HeroCellModel? {
        return presenter?.getHeroSeleсtCellModel(with: indexPath)
    }
}

// MARK: - SearchDelegate

extension HeroesListViewController: CharSearchControllerUiDelegate {
    func charSearchController(_ charSearchController: CharSearchController, didPresentSearchBarWithText text: String) {
         presenter?.handleDidPresentingSearchBar(with: text)
    }
    
    func charSearchController(_ charSearchController: CharSearchController, didDismissSearchBarWithText text: String) {
         presenter?.handleDidDismissingSearchBar(with: text)
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
    func reloadCollectionView() {
        heroesListView.reloadCollectionView()
    }
    
    func showActivityIndicator(_ show: Bool) {
        heroesListView.showActivityIndicator(show)
    }
    
    func moveUpCell(with indexPath: IndexPath) {
        heroesListView.moveUpCell(with: indexPath)
    }
    
    func setAlphaForCell(with indexPath: IndexPath, alpha: HeroCellAlpha) {
        heroesListView.setAlphaForCell(with: indexPath, alpha: alpha)
    }
    
    func setAlphaForEachVisibleCells(alpha: HeroCellAlpha) {
        heroesListView.setAlphaForEachVisibleCells(alpha: alpha)
    }
    
    func scrollCollectionView(to direction: ScrollDirection) {
        heroesListView.scrollCollectionView(to: direction)
    }
}
