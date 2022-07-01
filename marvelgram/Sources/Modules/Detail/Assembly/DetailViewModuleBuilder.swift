//
//  DetailViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

final class DetailViewModuleBuilder: ModuleBuilder {
    static func createModule(with type: ModuleType, coordinator: Coordinator) -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter(view: viewController)
        if case let .detail(data) = type {
            presenter.fillDataSource(with: data)
        }
        viewController.presenter = presenter
        
        return viewController
    }
}
