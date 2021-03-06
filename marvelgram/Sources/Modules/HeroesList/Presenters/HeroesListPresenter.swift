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
    private var isFoundHero = false
    
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
    
    private func convertToCellModel(from heroes: [Hero]) -> [HeroCellModel] {
        return heroes.map { HeroCellModel(hero: $0) }
    }
}

// MARK: - ViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
    func handleDidLoadView() {
        view?.showActivityIndicator(true)
        
        repository.getHeroes { [weak self] heroes in
            guard let self = self else { return }
            
            let models = self.convertToCellModel(from: heroes)
            self.dataSource.heroCellModels = models
            
            DispatchQueue.main.async {
                self.view?.showActivityIndicator(false)
                self.view?.reloadCollectionView()
            }
        }
    }
    
    func handleDidSelectingHeroCell(with indexPath: IndexPath) {
        guard let randHeroes = repository.getHeroesRandomly() else { return }
        
        let charModel = self.getHeroSeleсtCellModel(with: indexPath)
        let randomCharModels = convertToCellModel(from: randHeroes)
        let dataSource = HeroDetailsDataSource(heroSeleсtingCellModel: charModel, otherCharCellModels: randomCharModels)
        
        coordinator.startHeroDetailsEvent(with: dataSource)
    }
    
    func handleWillDisplayingHeroCell(with indexPath: IndexPath) {
        if isSearchModeEnabled {
            var alphaMode: HeroCellAlpha {
                return isFoundHero && indexPath == .zero ? .clear : .muddy
            }
            
            /* If DSC not used, then when scrolling up, cell may not have time to prepare */
            DispatchQueue.main.async {
                self.view?.setAlphaForCell(with: indexPath, alpha: alphaMode)
            }
            
        }
    }
    
    func handleDidShowingAnimationHeroCell(with result: Bool) {
        if result {
            DispatchQueue.main.async {
                self.view?.setAlphaForEachVisibleCells(alpha: .muddy)
                self.view?.setAlphaForCell(with: .zero, alpha: .clear)
            }
        }
    }
    
    func handleDidPresentingSearchBar(with text: String) {
        isSearchModeEnabled = true
        view?.setAlphaForEachVisibleCells(alpha: .muddy)
        
        if isFoundHero {
            view?.setAlphaForCell(with: .zero, alpha: .clear)
        }
    }
    
    func handleDidDismissingSearchBar(with text: String) {
        isSearchModeEnabled = false
        view?.setAlphaForEachVisibleCells(alpha: .clear)
    }
    
    func handleUpdatingSearchResults(with text: String) {
        isFoundHero = false
        view?.setAlphaForEachVisibleCells(alpha: .muddy)
        
        if text.isNotEmpty {
            for (index, hero) in dataSource.heroCellModels.enumerated() {
                let heroLowercased = hero.name.sanitized(with: ["-"])
                let textLowercased = text.sanitized(with: ["-"])
                
                if heroLowercased.contains(textLowercased) {
                    isFoundHero = true
                    view?.scrollCollectionView(to: .top)
                    
                    let detectedModel = dataSource.heroCellModels[index]
                    guard dataSource.heroCellModels.first != detectedModel else {
                        view?.setAlphaForCell(with: .zero, alpha: .clear)
                        return
                    }
                    
                    dataSource.heroCellModels.remove(at: index)
                    dataSource.heroCellModels.insert(detectedModel, at: .zero)
                    
                    view?.moveUpCell(with: IndexPath(item: index, section: .zero))
                    return
                }
            }
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
