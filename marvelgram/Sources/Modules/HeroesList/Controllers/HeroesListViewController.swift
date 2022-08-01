import UIKit

final class HeroesListViewController: UIViewController {
    
    var presenter: HeroesListViewOutput?
    
    private var heroesListView: HeroesListView {
        guard let castedView = view as? HeroesListView else {
            fatalError("TypeCasting Error: presenterView must be \(HeroesListView.self)")
        }
        
        return castedView
    }
    
    private let heroNavBarSearch: HeroSearchController = {
        HeroSearchController(searchResultsController: nil)
    }()
    
    private let marvelNavBarButton: MarvelBarButtonItem = {
        MarvelBarButtonItem()
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        setupDelegates()
        setupNavController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupDelegates()
        setupNavController()
    }
    
    override func loadView() {
        let view = HeroesListView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.handleDidLoadView()
    }
    
    private func setupDelegates() {
        heroNavBarSearch.resultsDelegate = self
        heroNavBarSearch.actionDelegate = self
        marvelNavBarButton.delegate = self
    }
    
    private func setupNavController() {
        // SearchBar
        navigationItem.searchController = heroNavBarSearch
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // ButtonBar
        navigationItem.leftBarButtonItem = marvelNavBarButton
    }
}

// MARK: - UiDelegate

extension HeroesListViewController: HeroesListViewUiDelegate {
    // - Actions
    func heroesListView(_ heroesListView: HeroesListView, willDisplayHeroWithIndexPath indexPath: IndexPath) {
        presenter?.handleWillDisplayingHeroCell(with: indexPath)
    }
    
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndexPath indexPath: IndexPath) {
        presenter?.handleDidSelectingHeroCell(with: indexPath)
    }
    
    func heroesListView(_ heroesListView: HeroesListView, didMoveUpHeroWithAnimationResult result: Bool) {
        presenter?.handleDidMovingUpAnimationHeroCell(with: result)
    }
    
    func heroesListView(_ heroesListView: HeroesListView, didChangeLayoutWithAnimationResult result: Bool) {
        presenter?.handleDidChangingFlowLayoutAnimation(with: result)
    }
    
    // - DataSource
    func heroesListView(_ heroesListView: HeroesListView, getCellsCountOf reuseIdentifier: String) -> Int? {
        presenter?.getHeroCellsCount()
    }
    
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndexPath indexPath: IndexPath) -> HeroCellModel? {
        presenter?.getHeroCellModel(with: indexPath)
    }
}

// MARK: - SearchDelegate

extension HeroesListViewController: HeroSearchControllerActionDelegate {
    func heroSearchController(_ heroSearchController: HeroSearchController, didPresentSearchBarWithText text: String) {
         presenter?.handleDidPresentingSearchBar(with: text)
    }
    
    func heroSearchController(_ heroSearchController: HeroSearchController, didDismissSearchBarWithText text: String) {
         presenter?.handleDidDismissingSearchBar(with: text)
    }
}

extension HeroesListViewController: HeroSearchControllerResultsDelegate {
    func heroSearchController(_ heroSearchController: HeroSearchController, didUpdateSearchResultsWithText text: String) {
        presenter?.handleUpdatingSearchResults(with: text)
    }
}

// MARK: - NavBarButtonDelegate

extension HeroesListViewController: NavBarButtonItemDelegate {
    func navBarButtonItem(_ navBarButtonItem: UIBarButtonItem, didTapNavBarButtonWithType type: NavBarButtonType) {
        presenter?.handleTappingNavBarButton(with: type)
    }
}

// MARK: - ViewInput

extension HeroesListViewController: HeroesListViewInput {
    func reloadCollectionView() {
        heroesListView.reloadCollectionView()
    }
    
    func showLaunchActivityIndicator(_ show: Bool) {
        heroesListView.showlaunchActivityIndicator(show)
    }
    
    func scrollCollectionView(to direction: ScrollDirection) {
        heroesListView.scrollCollectionView(to: direction)
    }
    
    func moveUpCell(with indexPath: IndexPath) {
        heroesListView.moveUpCell(with: indexPath)
    }
    
    func setAlphaForEachVisibleCells(alpha: HeroCellAlpha) {
        heroesListView.setAlphaForEachVisibleCells(alpha: alpha)
    }
    
    func setAlphaForCell(with indexPath: IndexPath, alpha: HeroCellAlpha) {
        heroesListView.setAlphaForCell(with: indexPath, alpha: alpha)
    }
    
    func updateFlowLayout(with type: FlowLayoutType) {
        heroesListView.updateFlowLayout(with: type)
    }
}
