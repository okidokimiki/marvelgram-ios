//
//  HeroDetailsViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

protocol HeroDetailsViewOutput {
    // Initilization
    init(view: HeroDetailsViewInput,
         repository: HeroesRepository,
         coordinator: HeroDetailsCoordinator)
    
    // Actions
    func handleAppearingView()
    func handleDidLayoutSubviews()
    func handleSelectingCharCell(with indexPath: IndexPath)
    
    // DataSource
    func getOtherCharCellsCount() -> Int?
    func getOtherCharCellModel(with indexPath: IndexPath) -> HeroCellModel?
}
