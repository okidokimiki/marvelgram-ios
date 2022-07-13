//
//  HeroesListViewOutput.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

protocol HeroesListViewOutput {
    // Initilization
    init(view: HeroesListViewInput,
         repository: HeroesRepository,
         dataSource: HeroesListDataSource,
         coordinator: HeroesListCoordinator)
    
    // Actions
    func handleDidLoadView()
    func handleSelectingHeroCell(with index: Int)
    func handlePresentingSearchBar(with text: String)
    func handleDismissingSearchBar(with text: String)
    func handleUpdatingSearchResults(with text: String)
    func handleTappingNavBarButton(with type: NavBarButtonType)
    
    // DataSource
    func getHeroSelсtCellsCount() -> Int?
    func getHeroSelсtCellModel(with index: Int) -> HeroSeleсtingCellModel
}
