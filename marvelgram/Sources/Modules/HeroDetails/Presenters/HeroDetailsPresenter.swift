final class HeroDetailsPresenter {
    
    weak var view: HeroDetailsViewInput?
    private let coordinator: HeroDetailsCoordinator
    
    required init(
        view: HeroDetailsViewInput,
        coordinator: HeroDetailsCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - ViewOutput

extension HeroDetailsPresenter: HeroDetailsViewOutput {
    // Actions
    func handleDidLayoutSubviews() {
        view?.finishLayoutSubviews()
    }
}
