//
//  AppCoordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 29.06.2022.
//

import UIKit

final class AppCoordinator {
    // MARK: - Public Properties
    
    var parent: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Private Properties
    
    private var navigationController: UINavigationController
    
    // MARK: - Initilization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - Coordinatable

extension AppCoordinator: Coordinator {
    func start() {
        let coordinator = MainCoordinator(navigationController: navigationController, parent: self)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
