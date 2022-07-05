//
//  HeroDetailsViewUiDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

protocol HeroDetailsViewUiDelegate: AnyObject {
    // DataSource
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getCellsCountOf reuseIdentifier: String) -> Int?
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getOtherCharCellModelWithIndex index: Int) -> HeroSeleсtingCellModel?
}
