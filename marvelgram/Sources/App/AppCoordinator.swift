import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow?
    private var navigationController: UINavigationController
    private(set) var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        configureWindow()
        // HeroesList
        let heroesListCoordinator = HeroesListCoordinator(navigationController: navigationController)
        heroesListCoordinator.start()
        
        childCoordinators.append(heroesListCoordinator)
    }
    
    private func configureWindow() {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .dark
        }
        window?.rootViewController = navigationController
    }
}
