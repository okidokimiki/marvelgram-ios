import Foundation

final class HeroesListPresenter {
    
    weak var view: HeroesListViewInput?
    private let dataSource: HeroesListDataSource
    private let repository: HeroesRepository
    private let coordinator: HeroesListCoordinator
    
    private var isSearchModeEnabled = false
    private var isFoundHero = false
    
    required init(
        view: HeroesListViewInput,
        dataSource: HeroesListDataSource,
        repository: HeroesRepository,
        coordinator: HeroesListCoordinator
    ) {
        self.view = view
        self.dataSource = dataSource
        self.repository = repository
        self.coordinator = coordinator
    }
    
    private func convertToCellModel(from heroes: [Hero]) -> [HeroCellModel] {
        heroes.map { HeroCellModel(hero: $0) }
    }
}

// MARK: - ViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
    // - Actions
    func handleDidLoadView() {
        view?.showLaunchActivityIndicator(true)
        
        repository.getHeroes { [weak self] heroes in
            guard let self = self else { return }
            
            let models = self.convertToCellModel(from: heroes)
            self.dataSource.heroCellModels = models
            
            DispatchQueue.main.async {
                self.view?.showLaunchActivityIndicator(false)
                self.view?.reloadCollectionView()
            }
        }
    }
    
    func handleDidSelectingHeroCell(with indexPath: IndexPath) {
        guard let randHeroes = repository.getHeroesRandomly() else { return }
        
        var dataSource: HeroDetailsDataSource {
            let heroCellModel = getHeroCellModel(with: indexPath)
            let randomHeroModels = convertToCellModel(from: randHeroes)
            
            return .init(selectedHeroCellModel: heroCellModel, otherHeroCellModels: randomHeroModels)
        }
        
        coordinator.startHeroDetailsEvent(with: dataSource)
    }
    
    func handleTappingNavBarButton(with type: NavBarButtonType) {
        print("did tap NavBarButton with type: \(type)")
    }
    
    func handleDidPresentingSearchBar(with text: String) {
        isSearchModeEnabled = true
        view?.setAlphaForEachVisibleCells(alpha: .muddy)
        
        guard isFoundHero else { return }
        view?.setAlphaForCell(with: .zero, alpha: .clear)
    }
    
    func handleDidDismissingSearchBar(with text: String) {
        isSearchModeEnabled = false
        view?.setAlphaForEachVisibleCells(alpha: .clear)
    }
    
    func handleUpdatingSearchResults(with text: String) {
        isFoundHero = false
        view?.setAlphaForEachVisibleCells(alpha: .muddy)
        
        guard !text.isEmpty else { return }
        for (index, hero) in dataSource.heroCellModels.enumerated() {
            let heroLowercased = hero.name.replacingOccurrences(with: ["-"])
            let textLowercased = text.replacingOccurrences(with: ["-"])
            
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
    
    func handleDidMovingUpAnimationHeroCell(with result: Bool) {
        guard result else { return }
        DispatchQueue.main.async {
            self.view?.setAlphaForEachVisibleCells(alpha: .muddy)
            self.view?.setAlphaForCell(with: .zero, alpha: .clear)
        }
    }
    
    func handleWillDisplayingHeroCell(with indexPath: IndexPath) {
        guard isSearchModeEnabled else { return }
        
        var alphaMode: HeroCellAlpha {
            isFoundHero && indexPath == .zero ? .clear : .muddy
        }
        
        DispatchQueue.main.async {
            self.view?.setAlphaForCell(with: indexPath, alpha: alphaMode)
        }
    }
    
    // - DataSource
    func getHeroCellsCount() -> Int? {
        dataSource.heroCellModels.count
    }
    
    func getHeroCellModel(with indexPath: IndexPath) -> HeroCellModel? {
        dataSource.heroCellModels[indexPath.item]
    }
}
