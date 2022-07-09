//
//  CharSearchController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 06.07.2022.
//

import UIKit

protocol CharSearchControllerResultsDelegate: AnyObject {
    func charSearchController(_ charSearchController: CharSearchController, didUpdateSearchResultsWithText text: String)
}

class CharSearchController: UISearchController {
    // MARK: - Properties
    
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
        searchResultsUpdater = self
        searchBar.placeholder = Localization.searchPlaceholderText.localizedString
        searchBar.spellCheckingType = .no
        searchBar.autocorrectionType = .no
        hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
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
