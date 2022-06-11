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
    
    func getHeroModelsCount() -> Int?
    func getHeroModel(with index: Int) -> HeroModel
}
