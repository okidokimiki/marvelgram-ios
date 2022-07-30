import UIKit

final class HeroesListViewController: UIViewController {
    
    var presenter: HeroesListViewOutput?
    
    private var heroesListView: HeroesListView {
        guard let castedView = view as? HeroesListView else {
            fatalError("TypeCasting Error: presenterView must be \(HeroesListView.self)")
        }
        
        return castedView
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

// MARK: - ViewInput

extension HeroesListViewController: HeroesListViewInput {
}
