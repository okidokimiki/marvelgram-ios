import UIKit

final class HeroesListModuleBuilder: ModuleBuilder {
    static func createModule(coordinator: Coordinator) -> UIViewController {
        guard let coordinator = coordinator as? HeroesListCoordinator else { return UIViewController() }
        let viewController = HeroesListViewController()
        let dataSource = HeroesListDataSource()
        let repository = HeroesRepository(networkService: NetworkService())
        let presenter = HeroesListPresenter(view: viewController,
                                            dataSource: dataSource,
                                            repository: repository,
                                            coordinator: coordinator)
        viewController.presenter = presenter
        
        return viewController
    }
}
