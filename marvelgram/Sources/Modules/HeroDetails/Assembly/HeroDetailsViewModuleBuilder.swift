import UIKit

final class HeroDetailsViewModuleBuilder: ModuleBuilder {
    static func createModule(with type: ModuleType, coordinator: Coordinator) -> UIViewController {
        guard let coordinator = coordinator as? HeroDetailsCoordinator else { return UIViewController() }
        let viewController = HeroDetailsViewController()
        let repository = HeroesRepository(networkService: NetworkService())
        let presenter = HeroDetailsPresenter(view: viewController,
                                             repository: repository,
                                             coordinator: coordinator)
        if case let .heroDetails(data) = type {
            presenter.fillDataSource(with: data)
        }
        viewController.presenter = presenter
        
        return viewController
    }
}
