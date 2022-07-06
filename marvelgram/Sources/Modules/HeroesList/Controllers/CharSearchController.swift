//
//  CharSearchController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 06.07.2022.
//

import UIKit

class CharSearchController: UISearchController {
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
        searchBar.placeholder = Localization.searchPlaceholderText.localizedString
        searchBar.spellCheckingType = .no
        searchBar.autocorrectionType = .no
    }
}
