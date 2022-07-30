import UIKit

final class HeroesListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let heroesListVC = HeroesListModuleBuilder.createModule(coordinator: self)
        navigationController.setViewControllers([heroesListVC], animated: true)
    }
}
