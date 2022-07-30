import Foundation

protocol HeroDetailsViewOutput {
    // Initilization
    init(view: HeroDetailsViewInput,
         coordinator: HeroDetailsCoordinator)
    
    // Actions
    func handleDidLayoutSubviews()
}
