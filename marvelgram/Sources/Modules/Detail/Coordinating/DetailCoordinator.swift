//
//  DetailCoordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 01.07.2022.
//

import UIKit

final class DetailCoordinator: Coordinator {
    let dataSource: DetailDataSource?
    
    // MARK: - Private Properties
    
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController
    
    // MARK: - Initilization
    
    init(navigationController: UINavigationController, dataSource: DetailDataSource?) {
        self.navigationController = navigationController
        self.dataSource = dataSource
    }
    
    // MARK: - Public Methods
    
    func start() {
        let detailVC = DetailViewModuleBuilder.createModule(with: .detail(dataSource), coordinator: self)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
