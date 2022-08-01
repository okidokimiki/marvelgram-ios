import UIKit

final class HeroDetailsCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    private let dataSource: HeroDetailsDataSource
    
    init(navigationController: UINavigationController, dataSource: HeroDetailsDataSource) {
        self.navigationController = navigationController
        self.dataSource = dataSource
    }
    
    func start() {
        let heroDetailsVC = HeroDetailsViewModuleBuilder.createModule(with: .heroDetails(dataSource), coordinator: self)
        navigationController.pushViewController(heroDetailsVC, animated: true)
    }
}
