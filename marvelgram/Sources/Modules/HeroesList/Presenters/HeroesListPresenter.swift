//
//  HeroesListPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

final class HeroesListPresenter {
    // MARK: - Properties
    
    weak var view: HeroesListViewInput?
    
    // MARK: - Private Properties
    
    private let repository: HeroesRepository
    private var dataSource: HeroesListDataSource
    private var coordinator: HeroesListCoordinator
    
    // MARK: - Initilization
    
    required init(
        view: HeroesListViewInput,
        repository: HeroesRepository,
        dataSource: HeroesListDataSource,
        coordinator: HeroesListCoordinator
    ) {
        self.view = view
        self.repository = repository
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
                self.view?.reloadHeroesSeleсtingCollectionView()
            }
        }
    }
}

// MARK: - MainViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
    // Actions
    func handleDidLoadView() {
        fetchHeroesAndReloadCollectionView()
    }
    
    func handleSelectingHeroCell(with index: Int) {
        guard let randHeroes = repository.getHeroesRandomly() else { return }
        
        let charModel = self.getHeroCellModel(with: index)
        let randomCharModels = randHeroes.map { HeroSeleсtingCellModel(hero: $0) }
        let dataSource = HeroDetailsDataSource(heroSeleсtingCellModel: charModel, otherCharCellModels: randomCharModels)
        
        coordinator.startHeroDetailsEvent(with: dataSource)
    }
    
    // DataSource
    func getHeroCellModelsCount() -> Int? {
        return dataSource.heroSeleсtingCellModels.count
    }
    
    func getHeroCellModel(with index: Int) -> HeroSeleсtingCellModel {
        return dataSource.heroSeleсtingCellModels[index]
    }
}
