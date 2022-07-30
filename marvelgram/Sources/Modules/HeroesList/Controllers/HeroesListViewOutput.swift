import Foundation

protocol HeroesListViewOutput {
    // Initilization
    init(view: HeroesListViewInput,
         coordinator: HeroesListCoordinator)
    
    // Actions
    func handleTappingNavBarButton(with type: NavBarButtonType)
}

enum NavBarButtonType {
    case marvel
}
