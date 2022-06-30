//
//  MainViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class MainViewModuleBuilder: ModuleBuilder {
    static func createModule(with type: ModuleType, _ coordinator: Coordinator) -> UIViewController {
        let viewController = MainViewController()
        let dataSource = MainDataSource()
        let presenter = MainPresenter(view: viewController,
                                      dataSource: dataSource)
        viewController.presenter = presenter
        
        return viewController
    }
}
