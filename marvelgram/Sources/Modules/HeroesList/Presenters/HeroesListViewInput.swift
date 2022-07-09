//
//  HeroesListViewInput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol HeroesListViewInput: AnyObject {
    func reloadHeroesSeleсtingCollectionView()
    func showActivityIndicator(_ show: Bool)
    func moveUpCell(with indexPath: IndexPath)
}
