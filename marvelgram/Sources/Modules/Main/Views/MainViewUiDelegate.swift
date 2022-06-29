//
//  MainViewUiDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol MainViewUiDelegate: AnyObject {
    // DataSource
    func mainView(_ mainView: MainView, getHeroCellModelWithIndex index: Int) -> HeroCellModel?
    func mainViewCellsCount(_ mainView: MainView) -> Int?
    
    // Actions
    func mainView(_ mainView: MainView, didSelectHeroWithIndex index: IndexPath)
}
