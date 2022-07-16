//
//  CharSearchController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 06.07.2022.
//

import UIKit

protocol CharSearchControllerUiDelegate: AnyObject {
    func charSearchController(_ charSearchController: CharSearchController, didPresentSearchBarWithText text: String)
    func charSearchController(_ charSearchController: CharSearchController, didDismissSearchBarWithText text: String)
}

protocol CharSearchControllerResultsDelegate: AnyObject {
    func charSearchController(_ charSearchController: CharSearchController, didUpdateSearchResultsWithText text: String)
}

class CharSearchController: UISearchController {
    // MARK: - Properties
    
    weak var uiDelegate: CharSearchControllerUiDelegate?
    weak var resultsDelegate: CharSearchControllerResultsDelegate?
    
    // MARK: - PrivateProperties
    
    private var searchBarIsntEmpty: Bool {
        guard let text = searchBar.text else { return true }
        
        return !text.isEmpty
    }
    
    // MARK: - Initilization
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        // Delegate
        delegate = self
        searchResultsUpdater = self
        
        // SearchBar
        searchBar.placeholder = AppLocalize.HeroesList.searchPlaceholderText
        searchBar.spellCheckingType = .no
        searchBar.autocorrectionType = .no
        searchBar.keyboardAppearance = .dark
        
        // NavigationBar
        hidesNavigationBarDuringPresentation = false
    }
}

// MARK: - UISearchControllerDelegate

extension CharSearchController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        guard let textSearch = searchController.searchBar.text else { return }
        
        uiDelegate?.charSearchController(self, didPresentSearchBarWithText: textSearch)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        guard let textSearch = searchController.searchBar.text else { return }
        
        uiDelegate?.charSearchController(self, didDismissSearchBarWithText: textSearch)
    }
}

// MARK: - UISearchResultsUpdating

extension CharSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let textSearch = searchController.searchBar.text else { return }
        
        if searchBarIsntEmpty {
            resultsDelegate?.charSearchController(self, didUpdateSearchResultsWithText: textSearch)
        }
    }
}
