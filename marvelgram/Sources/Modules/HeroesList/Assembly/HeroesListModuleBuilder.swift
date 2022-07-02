//
//  HeroesListModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class HeroesListModuleBuilder: ModuleBuilder {
    static func createModule(with type: ModuleType, coordinator: Coordinator) -> UIViewController {
        guard let coordinator = coordinator as? HeroesListCoordinator else { return UIViewController() }
        let viewController = HeroesListViewController()
        let dataSource = HeroesListDataSource()
        let networkService = NetworkService()
        let repository = HeroesRepository(networkService: networkService)
        let presenter = HeroesListPresenter(view: viewController,
                                            repository: repository,
                                            dataSource: dataSource,
                                            coordinator: coordinator)
        viewController.presenter = presenter
        
        return viewController
    }
}
