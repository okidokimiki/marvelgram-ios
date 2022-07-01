//
//  HeroesListPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

final class HeroesListPresenter {
    // MARK: - Public Properties
    
    weak var view: HeroesListViewInput?
    var coordinator: HeroesListCoordinator?
    
    // MARK: - Private Properties
    
    private let repository = HeroesRepository.shared
    private var dataSource: HeroesListDataSource
    
    // MARK: - Initilization
    
    required init(
        view: HeroesListViewInput,
        dataSource: HeroesListDataSource,
        coordinator: HeroesListCoordinator
    ) {
        self.view = view
        self.dataSource = dataSource
        self.coordinator = coordinator
    }
    
    // MARK: - Private Methods
    
    private func fetchHeroesAndReloadCollectionView() {
        view?.showActivityIndicator(true)
        
        repository.getHeroes { [weak self] heroes in
            guard let self = self else { return }
            
            let models = heroes.map { HeroSeleсtingCellModel(hero: $0) }
            self.dataSource.heroSeleсtingCellModels = models
            
            DispatchQueue.main.async {
                self.view?.showActivityIndicator(false)
                self.view?.reloadHeroesCollectionView()
            }
        }
    }
}

// MARK: - MainViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
    // actions
    func handleDidAppearingView() {
        fetchHeroesAndReloadCollectionView()
    }
    
    func handleSelectingHeroCell(with index: Int) {
        print("Selected heroCell with index \(index)")
        // собери DetailDataSource
        // coordinator?.startDetailEvent(with: <#T##DetailDataSource#>)
    }
    
    // dataSource
    func getHeroCellModelsCount() -> Int? {
        return dataSource.heroSeleсtingCellModels.count
    }
    
    func getHeroCellModel(with index: Int) -> HeroSeleсtingCellModel {
        return dataSource.heroSeleсtingCellModels[index]
    }
}
