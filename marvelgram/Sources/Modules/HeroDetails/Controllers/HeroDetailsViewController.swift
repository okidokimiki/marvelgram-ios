import UIKit

final class HeroDetailsViewController: UIViewController {
    
    var presenter: HeroDetailsViewOutput?
    
    private var heroDetailsView: HeroDetailsView {
        guard let castedView = view as? HeroDetailsView else {
            fatalError("TypeCasting Error: presenterView must be \(HeroDetailsView.self)")
        }
        
        return castedView
    }
    
    override func loadView() {
        let view = HeroDetailsView()
        view.uiDelegate = self
        self.view = view
    }
}

// MARK: - UiDelegate

extension HeroDetailsViewController: HeroDetailsViewUiDelegate {
}

// MARK: - ViewInput

extension HeroDetailsViewController: HeroDetailsViewInput {
}
