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
    
    override func loadView() {
        let view = HeroDetailsView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        presenter?.handleWillAppearingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presenter?.handleDidLayoutSubviews()
    }
    
    private func setupNavController(with model: HeroCellModel?) {
        let appearance = UINavigationBar.appearance()
        let attributes = [
            NSAttributedString.Key.font: AppFont.SFPro.regular17,
            NSAttributedString.Key.foregroundColor: AppColor.GlobalColor.font
        ]

        // - Title
        title = model?.name
        appearance.titleTextAttributes = attributes
    }
}

// MARK: - UiDelegate

extension HeroDetailsViewController: HeroDetailsViewUiDelegate {
    // Actions
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, didSelectHeroCellWith indexPath: IndexPath) {
        presenter?.handleDidSelectingHeroCell(with: indexPath)
    }
    
    // DataSource
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getOtherHeroCellModelWith indexPath: IndexPath) -> HeroCellModel? {
        presenter?.getOtherHeroCellModel(with: indexPath)
    }
    
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getCellsCountOf reuseIdentifier: String) -> Int? {
        presenter?.getOtherHeroCellsCount()
    }
}

// MARK: - ViewInput

extension HeroDetailsViewController: HeroDetailsViewInput {
    func updateUI(with model: HeroCellModel?) {
        setupNavController(with: model)
        heroDetailsView.updateUI(with: model)
    }
    
    func finishLayoutSubviews() {
        heroDetailsView.finishLayoutSubviews()
    }
}
