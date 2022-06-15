//
//  DetailsViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class DetailsViewModuleBuilder: ModuleBuilder {
    static func createModule() -> UIViewController {
        let viewController = DetailsViewController()
        let presenter = DetailsPresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
}
