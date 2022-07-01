//
//  MainViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class MainViewModuleBuilder: ModuleBuilder {
    static func createModule(with type: ModuleType, coordinator: Coordinator) -> UIViewController {
        guard let coordinator = coordinator as? HeroesListCoordinator else { return UIViewController() }
        let viewController = MainViewController()
        let dataSource = MainDataSource()
        let presenter = MainPresenter(view: viewController,
                                      dataSource: dataSource,
                                      coordinator: coordinator)
        viewController.presenter = presenter
        
        return viewController
    }
}
