import Foundation

protocol HeroDetailsViewOutput {
    // - Initilization
    init(view: HeroDetailsViewInput,
         repository: HeroesRepository,
         coordinator: HeroDetailsCoordinator)
    
    // - Actions
    func handleWillAppearingView()
    func handleDidLayoutSubviews()
    func handleDidSelectingHeroCell(with indexPath: IndexPath)
    
    // - DataSource
    func getOtherHeroCellsCount() -> Int?
    func getOtherHeroCellModel(with indexPath: IndexPath) -> HeroCellModel?
}
