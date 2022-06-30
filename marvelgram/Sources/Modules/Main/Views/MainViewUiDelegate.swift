//
//  MainViewUiDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol MainViewUiDelegate: AnyObject {
    // Actions
    func mainView(_ mainView: MainView, didSelectHeroWithIndex index: IndexPath)
    
    // DataSource
    func mainView(_ mainView: MainView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel?
    func mainViewCellsCount(_ mainView: MainView) -> Int?
}
