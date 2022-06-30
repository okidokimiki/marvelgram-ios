//
//  MainPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

final class MainPresenter {
    // MARK: - Public Properties
    
    weak var view: MainViewInput?
    
    // MARK: - Private Properties
    
    private let repository = HeroesRepository.shared
    private var dataSource: MainDataSource
    
    // MARK: - Initilization
    
    required init(
        view: MainViewInput,
        dataSource: MainDataSource
    ) {
        self.view = view
        self.dataSource = dataSource
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

extension MainPresenter: MainViewOutput {
    func handleDidAppearingView() {
        fetchHeroesAndReloadCollectionView()
    }
    
    func handleSelectingHeroCell(with index: Int) {
        print("Selected heroCell with index \(index)")
    }
    
    func getHeroCellModelsCount() -> Int? {
        return dataSource.heroSeleсtingCellModels.count
    }
    
    func getHeroCellModel(with index: Int) -> HeroSeleсtingCellModel {
        return dataSource.heroSeleсtingCellModels[index]
    }
}
