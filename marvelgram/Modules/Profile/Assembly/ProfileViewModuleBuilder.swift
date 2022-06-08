//
//  ProfileViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class ProfileViewModuleBuilder: ModuleBuilder {
    static func createModule() -> UIViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
}
