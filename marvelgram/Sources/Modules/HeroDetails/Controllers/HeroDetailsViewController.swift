import UIKit

final class HeroDetailsViewController: UIViewController {
    
    var presenter: HeroDetailsViewOutput?
    
    private var heroDetailsView: HeroDetailsView {
        guard let castedView = view as? HeroDetailsView else {
            fatalError("TypeCasting Error: presenterView must be \(HeroDetailsView.self)")
        }
        
        return castedView
    }
    
    private let backButton: BackBarButtonItem = {
        BackBarButtonItem()
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        setupNavController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupNavController()
    }
    
    override func loadView() {
        let view = HeroDetailsView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presenter?.handleDidLayoutSubviews()
    }
    
    private func setupNavController() {
        let appearance = UINavigationBar.appearance()
        let attributes = [
            NSAttributedString.Key.font: AppFont.SFPro.regular17,
            NSAttributedString.Key.foregroundColor: AppColor.GlobalColor.font
        ]
        
        // Title
        title = "Title"
        appearance.titleTextAttributes = attributes
        
        // NavigationBar
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: - UiDelegate

extension HeroDetailsViewController: HeroDetailsViewUiDelegate {
}

// MARK: - ViewInput

extension HeroDetailsViewController: HeroDetailsViewInput {
    // Actions
    func finishLayoutSubviews() {
        heroDetailsView.finishLayoutSubviews()
    }
}
