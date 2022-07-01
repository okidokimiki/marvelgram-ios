//
//  HeroesListViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol HeroesListViewOutput {
    init(view: HeroesListViewInput, dataSource: HeroesListDataSource, coordinator: HeroesListCoordinator)
    
    // Actions
    func handleDidAppearingView()
    func handleSelectingHeroCell(with index: Int)
    
    // DataSource
    func getHeroCellModelsCount() -> Int?
    func getHeroCellModel(with index: Int) -> HeroSeleсtingCellModel
}
