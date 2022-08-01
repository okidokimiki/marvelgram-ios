import Foundation

protocol HeroesListViewOutput {
    // Initilization
    init(view: HeroesListViewInput,
         dataSource: HeroesListDataSource,
         networker: NetworkService,
         coordinator: HeroesListCoordinator)
    
    // Actions
    func handleDidLoadView()
    func handleTappingNavBarButton(with type: NavBarButtonType)
    
    // DataSource
    func getHeroCellsCount() -> Int?
    func getHeroCellModel(with indexPath: IndexPath) -> HeroCellModel?
}

enum NavBarButtonType {
    case marvel
}
