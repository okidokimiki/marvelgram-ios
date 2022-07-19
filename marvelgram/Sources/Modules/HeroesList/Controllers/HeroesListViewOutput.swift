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
    func handleDidSelectingHeroCell(with indexPath: IndexPath)
    func handleWillDisplayingHeroCell(with indexPath: IndexPath)
    func handleDidPresentingSearchBar(with text: String)
    func handleDidDismissingSearchBar(with text: String)
    func handleUpdatingSearchResults(with text: String)
    func handleTappingNavBarButton(with type: NavBarButtonType)
    
    // DataSource
    func getHeroSeleсtCellsCount() -> Int?
    func getHeroSeleсtCellModel(with indexPath: IndexPath) -> HeroCellModel
}
