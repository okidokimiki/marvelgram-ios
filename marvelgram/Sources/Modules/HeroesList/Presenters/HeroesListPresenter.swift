import Foundation

final class HeroesListPresenter {
    
    weak var view: HeroesListViewInput?
    private let dataSource: HeroesListDataSource
    private let networker: NetworkService
    private let coordinator: HeroesListCoordinator
    
    required init(
        view: HeroesListViewInput,
        dataSource: HeroesListDataSource,
        networker: NetworkService,
        coordinator: HeroesListCoordinator
    ) {
        self.view = view
        self.dataSource = dataSource
        self.networker = networker
        self.coordinator = coordinator
    }
    
    private func convertToCellModel(from heroes: [Hero]) -> [HeroCellModel] {
        heroes.map { HeroCellModel(hero: $0) }
    }
}

// MARK: - ViewOutput

extension HeroesListPresenter: HeroesListViewOutput {
    func handleDidLoadView() {
        view?.showLaunchActivityIndicator(true)
        
        networker.fetch(with: API.upstartsMarvelgram, of: [Hero].self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedData):
                guard let heroes = fetchedData as? [Hero] else { return }
                let models = self.convertToCellModel(from: heroes)
                self.dataSource.heroCellModels = models
                
                DispatchQueue.main.async {
                    self.view?.showLaunchActivityIndicator(false)
                    self.view?.reloadCollectionView()
                }
            case .failure(let netError):
                print(netError.localizedDescription)
            }
        }
    }
    
    func handleTappingNavBarButton(with type: NavBarButtonType) {
        print("did tap NavBarButton with type: \(type)")
    }
    
    func getHeroCellsCount() -> Int? {
        dataSource.heroCellModels.count
    }
    
    func getHeroCellModel(with indexPath: IndexPath) -> HeroCellModel? {
        dataSource.heroCellModels[indexPath.item]
    }
}
