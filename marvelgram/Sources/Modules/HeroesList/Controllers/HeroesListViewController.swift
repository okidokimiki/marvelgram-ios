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
}

// MARK: - UiDelegate

extension HeroesListViewController: HeroesListViewUiDelegate {
}

// MARK: - NavBarButtonDelegate

extension HeroesListViewController: NavBarButtonItemDelegate {
    func navBarButtonItem(_ navBarButtonItem: UIBarButtonItem, didTapNavBarButtonWithType type: NavBarButtonType) {
        presenter?.handleTappingNavBarButton(with: type)
    }
}

// MARK: - ViewInput

extension HeroesListViewController: HeroesListViewInput {
}
