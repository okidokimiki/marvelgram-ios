import Foundation

protocol HeroesListViewOutput {
    // - Initilization
    init(view: HeroesListViewInput,
         dataSource: HeroesListDataSource,
         repository: HeroesRepository,
         coordinator: HeroesListCoordinator)
    
    // - Actions
    func handleDidLoadView()
    func handleTappingNavBarButton(with type: NavBarButtonType)
    
    // - Actions
    func getHeroCellsCount() -> Int?
    func getHeroCellModel(with indexPath: IndexPath) -> HeroCellModel?
}

enum NavBarButtonType {
    case marvel
}
