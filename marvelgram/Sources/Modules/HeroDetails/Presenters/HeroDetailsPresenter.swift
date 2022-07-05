//
//  DetailPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

final class HeroDetailsPresenter {
    // MARK: - Properties
    
    weak var view: HeroDetailsViewInput?
    
    // MARK: - Private Properties
    private var repository: HeroesRepository
    private var dataSource: HeroDetailsDataSource?
    private var coordinator: HeroDetailsCoordinator
    
    // MARK: - Initilization
    
    required init(
        view: HeroDetailsViewInput,
        repository: HeroesRepository,
        coordinator: HeroDetailsCoordinator
    ) {
        self.view = view
        self.repository = repository
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    
    func fillDataSource(with data: HeroDetailsDataSource?) {
        dataSource = data
    }
    
    // MARK: - Private Methods
    
    private func updateUI() {
        let model = dataSource?.heroSeleсtingCellModel
        view?.updateUI(with: model)
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.view?.reloadCollectionView()
        }
    }
    
    private func updateUI(withSelectedChar index: Int) {
        guard
            let selectedChar = dataSource?.otherCharCellModels?[index],
            let randHeroes = repository.getHeroesRandomly()
        else {
            fatalError("DataSource Error: couldn`t guard data on HeroDetails Screen.")
        }
        
        dataSource?.heroSeleсtingCellModel = selectedChar
        dataSource?.otherCharCellModels = randHeroes.map { HeroSeleсtingCellModel(hero: $0) }
        
        reloadCollectionView()
        updateUI()
    }
}

// MARK: - DetailViewOutput

extension HeroDetailsPresenter: HeroDetailsViewOutput {
    // Actions
    func handleDidLoadView() {
        reloadCollectionView()
    }
    
    func handleDidLayoutSubviews() {
        view?.finishLayoutSubviews()
    }
    
    func handleAppearingView() {
        updateUI()
    }
    
    func handleSelectingCharCell(with index: Int) {
        updateUI(withSelectedChar: index)
    }
    
    // DataSource
    func getOtherCharCellModel(with index: Int) -> HeroSeleсtingCellModel? {
        return dataSource?.otherCharCellModels?[index]
    }
    
    func getOtherCharCellsCount() -> Int? {
        return dataSource?.otherCharCellModels?.count
    }
}
