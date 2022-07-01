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
    
    // MARK: - Public Methods
    
    func start() {
        let mainVC = MainViewModuleBuilder.createModule(with: .default, coordinator: self)
        navigationController.setViewControllers([mainVC], animated: true)
    }
    
    func startDetailEvent(with dataSource: DetailDataSource) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, dataSource: dataSource)
        detailCoordinator.start()
        
        childCoordinators.append(detailCoordinator)
    }
}
