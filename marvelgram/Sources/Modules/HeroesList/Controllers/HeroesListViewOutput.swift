import Foundation

protocol HeroesListViewOutput {
    // Initilization
    init(view: HeroesListViewInput,
         coordinator: HeroesListCoordinator)
}
