//
//  GalleryViewModuleBuilder.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class GalleryViewModuleBuilder: ModuleBuilder {
    static func createModule() -> UIViewController {
        let viewController = GalleryViewController()
        let presenter = GalleryPresenter(view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
}
