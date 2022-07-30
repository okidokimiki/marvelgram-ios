import UIKit

final class HeroesListModuleBuilder: ModuleBuilder {
    static func createModule(coordinator: Coordinator) -> UIViewController {
        guard let coordinator = coordinator as? HeroesListCoordinator else { return UIViewController() }
        let viewController = HeroesListViewController()
        let presenter = HeroesListPresenter(view: viewController,
                                            coordinator: coordinator)
        viewController.presenter = presenter
        
        return viewController
    }
}
