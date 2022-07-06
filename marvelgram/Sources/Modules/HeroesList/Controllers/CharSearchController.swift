//
//  CharSearchController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 06.07.2022.
//

import UIKit

protocol CharSearchControllerResultsDelegate: AnyObject {
}

class CharSearchController: UISearchController {
    weak var resultDelegate: CharSearchControllerResultsDelegate?
    
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
    }
}

// MARK: - UISearchResultsUpdating

extension CharSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
