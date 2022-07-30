import UIKit

final class HeroDetailsViewModuleBuilder: ModuleBuilder {
    static func createModule(coordinator: Coordinator) -> UIViewController {
        guard let coordinator = coordinator as? HeroDetailsCoordinator else { return UIViewController() }
        let viewController = HeroDetailsViewController()
        let presenter = HeroDetailsPresenter(view: viewController,
                                             coordinator: coordinator)
        viewController.presenter = presenter
        
        return viewController
    }
}
