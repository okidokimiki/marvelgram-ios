//
//  GalleryPresenterProtocol.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol GalleryPresenterProtocol {
    init(view: GalleryViewProtocol, galleryDataSource: GalleryDataSource)
    
    func handleDidAppearingView()
    
    func getHeroViewModelsCount() -> Int?
    func getHeroViewModel(with index: Int) -> HeroViewModel
}
