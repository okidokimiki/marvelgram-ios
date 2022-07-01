//
//  MainViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol MainViewOutput {
    init(view: MainViewInput, dataSource: MainDataSource, coordinator: HeroesListCoordinator)
    
    // Actions
    func handleDidAppearingView()
    func handleSelectingHeroCell(with index: Int)
    
    // DataSource
    func getHeroCellModelsCount() -> Int?
    func getHeroCellModel(with index: Int) -> HeroSeleсtingCellModel
}
