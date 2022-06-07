//
//  GalleryPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

class GalleryPresenter {
    // MARK: - Public Properties
    
    weak var view: GalleryViewProtocol?
    
    // MARK: - Private Properties
    
    private let networkManager = NetworkManager.shared
    private var galleryDataSource: GalleryDataSource
    
    // MARK: - Initilization
    
    required init(
        view: GalleryViewProtocol,
        galleryDataSource: GalleryDataSource
    ) {
        self.view = view
        self.galleryDataSource = galleryDataSource
    }
    }
}

// MARK: - GalleryPresenterProtocol

extension GalleryPresenter: GalleryPresenterProtocol {
}
