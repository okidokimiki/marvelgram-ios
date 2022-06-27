//
//  GalleryViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol GalleryViewOutput {
    init(view: GalleryViewInput, galleryDataSource: GalleryDataSource)
    
    func handleDidAppearingView()
    
    func getHeroCellModelsCount() -> Int?
    func getHeroCellModel(with index: Int) -> HeroCellModel
}
