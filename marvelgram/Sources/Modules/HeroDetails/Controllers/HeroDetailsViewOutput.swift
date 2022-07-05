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
    func handleDidLoadView()
    func handleAppearingView()
    func handleDidLayoutSubviews()
    func handleSelectingCharCell(with index: Int)
    
    // DataSource
    func getOtherCharCellsCount() -> Int?
    func getOtherCharCellModel(with index: Int) -> HeroSeleсtingCellModel?
}
