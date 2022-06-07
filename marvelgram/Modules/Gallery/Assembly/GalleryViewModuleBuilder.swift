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
        let galleryDataSource = GalleryDataSource()
        let presenter = GalleryPresenter(view: viewController,
                                         galleryDataSource: galleryDataSource)
        viewController.presenter = presenter
        
        return viewController
    }
}
