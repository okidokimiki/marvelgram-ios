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
        setupNavController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        marvelNavBarButton.delegate = self
        setupNavController()
    }
    
    override func loadView() {
        let view = HeroesListView()
        view.uiDelegate = self
        self.view = view
    }
    
    private func setupNavController() {
        // ButtonBar
        navigationItem.leftBarButtonItem = marvelNavBarButton
        
        // NavigationBar
        /* These two lines solve such a problem: Navigation Bar changes its background color when scroll the view.
         
         I understand that this is a rather bad decision, because of which new problems may "pop out" in the future.
         If you find a better solution, write to me :) */
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
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
