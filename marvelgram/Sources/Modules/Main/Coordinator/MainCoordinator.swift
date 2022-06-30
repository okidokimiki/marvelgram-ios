//
//  MainCoordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 30.06.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Public Properties

    weak var parent: Coordinator?
    var childCoordinators: [Coordinator] = []

    // MARK: - Private Properties

    private let navigationController: UINavigationController

    // MARK: - Initilization

    init(navigationController: UINavigationController, parent: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parent = parent
    }

    // MARK: - Public Methods

    func start() {
        let viewController = MainViewModuleBuilder.createModule(with: .default, self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
