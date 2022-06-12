//
//  GalleryViewUiDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol GalleryViewUiDelegate: AnyObject {
    func galleryView(_ galleryView: GalleryView, getHeroCellModelWithIndex index: Int) -> HeroCellModel?
    func galleryViewCellsCount(_ galleryView: GalleryView) -> Int?
}
