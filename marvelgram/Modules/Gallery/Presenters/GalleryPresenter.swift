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
    
    // MARK: - Initilization
    
    required init(view: GalleryViewProtocol) {
        self.view = view
    }
}

// MARK: - GalleryPresenterProtocol

extension GalleryPresenter: GalleryPresenterProtocol {
}
