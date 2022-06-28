//
//  DetailViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class DetailViewModuleBuilder: ModuleBuilder {
    static func createModule() -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
}
