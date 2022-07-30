import UIKit

final class HeroDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let heroDetailsVC = HeroDetailsViewModuleBuilder.createModule(coordinator: self)
        navigationController.pushViewController(heroDetailsVC, animated: true)
    }
}
