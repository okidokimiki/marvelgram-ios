import Foundation

final class HeroesListPresenter {
    
    weak var view: HeroesListViewInput?
    private let dataSource: HeroesListDataSource
    private let repository: HeroesRepository
    private let coordinator: HeroesListCoordinator
    
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
    
    // - DataSource
    func getHeroCellsCount() -> Int? {
        dataSource.heroCellModels.count
    }
    
    func getHeroCellModel(with indexPath: IndexPath) -> HeroCellModel? {
        dataSource.heroCellModels[indexPath.item]
    }
}
