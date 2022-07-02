//
//  HeroesListViewUiDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol HeroesListViewUiDelegate: AnyObject {
    // Actions
    func heroesListView(_ heroesListView: HeroesListView, didSelectHeroWithIndex index: IndexPath)
    
    // DataSource
    func heroesListView(_ heroesListView: HeroesListView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel?
    func heroesListViewCellsCount(_ heroesListView: HeroesListView) -> Int?
}
