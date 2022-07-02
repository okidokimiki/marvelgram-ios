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
                self.view?.reloadHeroesCollectionView()
            }
        }
    }
}

// MARK: - MainViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
    // Actions
    func handleDidAppearingView() {
        fetchHeroesAndReloadCollectionView()
    }
    
    func handleSelectingHeroCell(with index: Int) {
        print("Selected heroCell with index \(index)")
        let model = self.getHeroCellModel(with: index)
        let dataSource = HeroDetailsDataSource(heroSeleсtingCellModel: model)
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
