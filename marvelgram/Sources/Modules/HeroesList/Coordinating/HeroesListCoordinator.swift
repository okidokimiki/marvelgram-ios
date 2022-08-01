import UIKit

final class HeroesListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let heroesListVC = HeroesListModuleBuilder.createModule(with: .default, coordinator: self)
        navigationController.setViewControllers([heroesListVC], animated: true)
    }
    
    func startHeroDetailsEvent(with dataSource: HeroDetailsDataSource) {
        let heroDetailsCoordinator = HeroDetailsCoordinator(navigationController: navigationController,
                                                            dataSource: dataSource)
        heroDetailsCoordinator.start()
        
        childCoordinators.append(heroDetailsCoordinator)
    }
}
