import Foundation

protocol HeroesListViewOutput {
    // - Initilization
    init(view: HeroesListViewInput,
         dataSource: HeroesListDataSource,
         repository: HeroesRepository,
         coordinator: HeroesListCoordinator)
    
    // - Actions
    func handleDidLoadView()
    func handleWillDisplayingHeroCell(with indexPath: IndexPath)
    func handleDidSelectingHeroCell(with indexPath: IndexPath)
    func handleTappingNavBarButton(with type: NavBarButtonType)
    func handleDidPresentingSearchBar(with text: String)
    func handleDidDismissingSearchBar(with text: String)
    func handleUpdatingSearchResults(with text: String)
    func handleDidMovingUpAnimationHeroCell(with result: Bool)
    func handleDidChangingFlowLayoutAnimation(with result: Bool)
    
    // - DataSource
    func getHeroCellsCount() -> Int?
    func getHeroCellModel(with indexPath: IndexPath) -> HeroCellModel?
}

enum NavBarButtonType {
    case marvel
}
