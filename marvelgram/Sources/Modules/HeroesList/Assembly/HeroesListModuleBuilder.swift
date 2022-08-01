import UIKit

final class HeroesListModuleBuilder: ModuleBuilder {
    static func createModule(coordinator: Coordinator) -> UIViewController {
        guard let coordinator = coordinator as? HeroesListCoordinator else { return UIViewController() }
        let viewController = HeroesListViewController()
        let dataSource = HeroesListDataSource()
        let networker = NetworkService()
        let presenter = HeroesListPresenter(view: viewController,
                                            dataSource: dataSource,
                                            networker: networker,
                                            coordinator: coordinator)
        viewController.presenter = presenter
        
        return viewController
    }
}
