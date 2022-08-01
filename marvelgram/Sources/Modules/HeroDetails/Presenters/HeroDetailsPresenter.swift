import Foundation

final class HeroDetailsPresenter {
    
    weak var view: HeroDetailsViewInput?
    private var dataSource: HeroDetailsDataSource?
    private let repository: HeroesRepository
    private let coordinator: HeroDetailsCoordinator
    
    required init(
        view: HeroDetailsViewInput,
        repository: HeroesRepository,
        coordinator: HeroDetailsCoordinator
    ) {
        self.view = view
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func fillDataSource(with data: HeroDetailsDataSource?) {
        dataSource = data
    }
    
    private func convertToCellModel(from heroes: [Hero]) -> [HeroCellModel] {
        heroes.map { HeroCellModel(hero: $0) }
    }
}

// MARK: - ViewOutput

extension HeroDetailsPresenter: HeroDetailsViewOutput {
    // - Actions
    func handleWillAppearingView() {
        view?.updateUI(with: dataSource?.selectedHeroCellModel)
    }
    
    func handleDidLayoutSubviews() {
        view?.finishLayoutSubviews()
    }
    
    func handleDidSelectingHeroCell(with indexPath: IndexPath) {
        guard
            let selectedHeroModel = dataSource?.otherHeroCellModels?[indexPath.item],
            let randHeroes = repository.getHeroesRandomly()
        else {
            fatalError("DataSource Error: couldn`t guard data on HeroDetails Screen.")
        }
        let otherHeroModels = convertToCellModel(from: randHeroes)
        
        dataSource?.selectedHeroCellModel = selectedHeroModel
        dataSource?.otherHeroCellModels = otherHeroModels
        view?.updateUI(with: dataSource?.selectedHeroCellModel)
    }
    
    // - DataSource
    func getOtherHeroCellsCount() -> Int? {
        dataSource?.otherHeroCellModels?.count
    }
    
    func getOtherHeroCellModel(with indexPath: IndexPath) -> HeroCellModel? {
        dataSource?.otherHeroCellModels?[indexPath.item]
    }
}
