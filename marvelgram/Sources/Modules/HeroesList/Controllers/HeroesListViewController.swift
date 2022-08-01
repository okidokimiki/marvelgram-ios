import UIKit

final class HeroesListViewController: UIViewController {
    
    var presenter: HeroesListViewOutput?
    
    private var heroesListView: HeroesListView {
        guard let castedView = view as? HeroesListView else {
            fatalError("TypeCasting Error: presenterView must be \(HeroesListView.self)")
        }
        
        return castedView
    }
    
    private let marvelNavBarButton: MarvelBarButtonItem = {
        MarvelBarButtonItem()
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        marvelNavBarButton.delegate = self
        navigationItem.leftBarButtonItem = marvelNavBarButton
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        marvelNavBarButton.delegate = self
        navigationItem.leftBarButtonItem = marvelNavBarButton
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
}

// MARK: - UiDelegate

extension HeroesListViewController: HeroesListViewUiDelegate {
    // - Actions
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndexPath indexPath: IndexPath) {
        presenter?.handleDidSelectingHeroCell(with: indexPath)
    }
    
    // - DataSource
    func heroesListView(_ heroesListView: HeroesListView, getCellsCountOf reuseIdentifier: String) -> Int? {
        presenter?.getHeroCellsCount()
    }
    
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndexPath indexPath: IndexPath) -> HeroCellModel? {
        presenter?.getHeroCellModel(with: indexPath)
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
}
