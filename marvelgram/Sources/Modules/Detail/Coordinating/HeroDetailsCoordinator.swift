//
//  HeroDetailsCoordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 01.07.2022.
//

import UIKit

final class HeroDetailsCoordinator: Coordinator {
    let dataSource: HeroDetailsDataSource?
    
    // MARK: - Private Properties
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    
    // MARK: - Initilization
    
    init(navigationController: UINavigationController, dataSource: HeroDetailsDataSource?) {
        self.navigationController = navigationController
        self.dataSource = dataSource
    }
    
    // MARK: - Public Methods
    
    func start() {
        let heroDetailsVC = HeroDetailsViewModuleBuilder.createModule(with: .detail(dataSource), coordinator: self)
        navigationController.pushViewController(heroDetailsVC, animated: true)
    }
}
