//
//  HeroDetailsViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

final class HeroDetailsViewModuleBuilder: ModuleBuilder {
    static func createModule(with type: ModuleType, coordinator: Coordinator) -> UIViewController {
        let viewController = HeroDetailsViewController()
        let presenter = HeroDetailsPresenter(view: viewController)
        if case let .heroDetails(data) = type {
            presenter.fillDataSource(with: data)
        }
        viewController.presenter = presenter
        
        return viewController
    }
}
