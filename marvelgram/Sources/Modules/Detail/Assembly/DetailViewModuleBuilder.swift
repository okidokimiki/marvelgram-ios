//
//  DetailViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

final class DetailViewModuleBuilder: ModuleBuilder {
    static func createModule(with type: ModuleType, _ coordinator: Coordinator) -> UIViewController {
        let viewController = DetailViewController()
        let dataSource = DetailDataSource()
        let presenter = DetailPresenter(view: viewController,
                                        dataSource: dataSource)
        viewController.presenter = presenter
        
        return viewController
    }
}
