//
//  HeroesListCoordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 01.07.2022.
//

import UIKit

final class HeroesListCoordinator: Coordinator {
    // MARK: - Private Properties
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    
    // MARK: - Initilization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
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
