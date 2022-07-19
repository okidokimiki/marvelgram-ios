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
    
    private var isSearchModeEnabled = false
    
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
    
    private func makeSeleсtCellModels(from heroes: [Hero]) -> [HeroCellModel] {
        return heroes.map { HeroCellModel(hero: $0) }
    }
    
    private func makeDataSource(from seleсtModel: HeroCellModel?, and otherCharModels: [HeroCellModel]?) -> HeroDetailsDataSource {
        return HeroDetailsDataSource(heroSeleсtingCellModel: seleсtModel, otherCharCellModels: otherCharModels)
    }
}

// MARK: - ViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
    func handleDidLoadView() {
        view?.showActivityIndicator(true)
        
        repository.getHeroes { [weak self] heroes in
            guard let self = self else { return }
            
            let models = self.makeSeleсtCellModels(from: heroes)
            self.dataSource.heroCellModels = models
            
            DispatchQueue.main.async {
                self.view?.showActivityIndicator(false)
                self.view?.reloadHeroesSeleсtingCollectionView()
            }
        }
    }
    
    func handleDidSelectingHeroCell(with indexPath: IndexPath) {
        guard let randHeroes = repository.getHeroesRandomly() else { return }
        
        let charModel = self.getHeroSeleсtCellModel(with: indexPath)
        let randomCharModels = makeSeleсtCellModels(from: randHeroes)
        let dataSource = makeDataSource(from: charModel, and: randomCharModels)
        
        coordinator.startHeroDetailsEvent(with: dataSource)
    }
    
    func handleWillDisplayingHeroCell(with indexPath: IndexPath) {
        if isSearchModeEnabled {
            DispatchQueue.main.async {
                guard let searchedIndexPath = self.dataSource.searchedHeroCellIndexPath else {
                    self.view?.setAlphaForCell(with: indexPath, alpha: .muddy)
                    return
                }
                
                self.view?.setAlphaForCell(with: indexPath, alpha: searchedIndexPath == indexPath ? .clear : .muddy)
            }
        }
    }
    
    func handleDidPresentingSearchBar(with text: String) {
        isSearchModeEnabled = true
        view?.setAlphaForEachVisibleCells(alpha: .muddy)
        
        if let searchedIndexPath = dataSource.searchedHeroCellIndexPath {
            view?.setAlphaForCell(with: searchedIndexPath, alpha: .clear)
        }
    }
    
    func handleDidDismissingSearchBar(with text: String) {
        isSearchModeEnabled = false
        view?.setAlphaForEachVisibleCells(alpha: .clear)
    }
    
    func handleUpdatingSearchResults(with text: String) {
        view?.setAlphaForEachVisibleCells(alpha: .muddy)
        
        if text.isNotEmpty {
            if let searchedIndexPath = dataSource.searchedHeroCellIndexPath {
                view?.setAlphaForCell(with: searchedIndexPath, alpha: .clear)
            }
            
            for (index, hero) in dataSource.heroCellModels.enumerated() {
                let heroLowercased = hero.name.lowercased()
                let textLowercased = text.lowercased()
                
                if heroLowercased.contains(textLowercased) {
                    let detectedModel = dataSource.heroCellModels[index]
                    dataSource.heroCellModels.remove(at: index)
                    dataSource.heroCellModels.insert(detectedModel, at: .zero)
                    dataSource.searchedHeroCellIndexPath = .zero
                    
                    view?.moveUpCell(with: IndexPath(item: index, section: .zero))
                    return
                }
            }
        } else {
            dataSource.searchedHeroCellIndexPath = .none
        }
    }
    
    func handleTappingNavBarButton(with type: NavBarButtonType) {
        print("Did tap navBar button with type: \(type)")
    }
    
    // DataSource
    func getHeroSeleсtCellsCount() -> Int? {
        return dataSource.heroCellModels.count
    }
    
    func getHeroSeleсtCellModel(with indexPath: IndexPath) -> HeroCellModel {
        return dataSource.heroCellModels[indexPath.item]
    }
}
