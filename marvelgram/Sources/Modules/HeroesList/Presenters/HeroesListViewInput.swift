//
//  HeroesListViewInput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol HeroesListViewInput: AnyObject {
    func reloadCollectionView()
    func showActivityIndicator(_ show: Bool)
    func moveUpCell(with indexPath: IndexPath)
    func setAlphaForCell(with indexPath: IndexPath, alpha: HeroCellAlpha)
    func setAlphaForEachVisibleCells(alpha: HeroCellAlpha)
    func scrollCollectionView(to direction: ScrollDirection)
}
