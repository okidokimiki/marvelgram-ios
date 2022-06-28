//
//  MainViewUiDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

protocol MainViewUiDelegate: AnyObject {
    func mainView(_ mainView: MainView, getHeroCellModelWithIndex index: Int) -> HeroCellModel?
    func mainViewCellsCount(_ mainView: MainView) -> Int?
}
