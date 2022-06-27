//
//  GalleryViewInput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol GalleryViewInput: AnyObject {
    func reloadHeroesCollectionView()
    func showActivityIndicator(_ show: Bool)
}
