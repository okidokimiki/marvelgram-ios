import UIKit

protocol HeroSearchControllerActionDelegate: AnyObject {
    func heroSearchController(_ heroSearchController: HeroSearchController, didPresentSearchBarWithText text: String)
    func heroSearchController(_ heroSearchController: HeroSearchController, didDismissSearchBarWithText text: String)
}

protocol HeroSearchControllerResultsDelegate: AnyObject {
    func heroSearchController(_ heroSearchController: HeroSearchController, didUpdateSearchResultsWithText text: String)
}

final class HeroSearchController: UISearchController {
    
    weak var actionDelegate: HeroSearchControllerActionDelegate?
    weak var resultsDelegate: HeroSearchControllerResultsDelegate?
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        
        configure()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupDelegates()
    }
    
    private func configure() {
        // SearchBar
        searchBar.placeholder = AppLocalize.HeroesList.searchPlaceholderText
        searchBar.spellCheckingType = .no
        searchBar.autocorrectionType = .no
        searchBar.keyboardAppearance = .dark
        
        // NavigationBar
        hidesNavigationBarDuringPresentation = false
    }
    
    private func setupDelegates() {
        searchResultsUpdater = self
        delegate = self
    }
}

// MARK: - UISearchControllerDelegate

extension HeroSearchController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        guard let textSearch = searchController.searchBar.text else { return }
        
        actionDelegate?.heroSearchController(self, didPresentSearchBarWithText: textSearch)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        guard let textSearch = searchController.searchBar.text else { return }
        
        actionDelegate?.heroSearchController(self, didDismissSearchBarWithText: textSearch)
    }
}

// MARK: - UISearchResultsUpdating

extension HeroSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let textSearch = searchController.searchBar.text else { return }
        
        resultsDelegate?.heroSearchController(self, didUpdateSearchResultsWithText: textSearch)
    }
}
