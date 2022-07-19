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
    
    private func makeCharCellModels(from heroes: [Hero]) -> [HeroCellModel] {
        return heroes.map { HeroCellModel(hero: $0) }
    }
    
    private func updateDataSource(with seleсtCharModel: HeroCellModel?, and otherCharModels: [HeroCellModel]?) {
        dataSource?.heroSeleсtingCellModel = seleсtCharModel
        dataSource?.otherCharCellModels = otherCharModels
    }
    
    private func updateUI() {
        let model = dataSource?.heroSeleсtingCellModel
        view?.updateUI(with: model)
    }
}

// MARK: - ViewOutput

extension HeroDetailsPresenter: HeroDetailsViewOutput {
    // Actions
    func handleDidLayoutSubviews() {
        view?.finishLayoutSubviews()
    }
    
    func handleAppearingView() {
        updateUI()
    }
    
    func handleSelectingCharCell(with index: Int) {
        guard
            let selectedCharModel = dataSource?.otherCharCellModels?[index],
            let randHeroes = repository.getHeroesRandomly()
        else {
            fatalError("DataSource Error: couldn`t guard data on HeroDetails Screen.")
        }
        let otherCharModels = makeCharCellModels(from: randHeroes)
        
        updateDataSource(with: selectedCharModel, and: otherCharModels)
        updateUI()
    }
    
    // DataSource
    func getOtherCharCellModel(with index: Int) -> HeroCellModel? {
        return dataSource?.otherCharCellModels?[index]
    }
    
    func getOtherCharCellsCount() -> Int? {
        return dataSource?.otherCharCellModels?.count
    }
}
