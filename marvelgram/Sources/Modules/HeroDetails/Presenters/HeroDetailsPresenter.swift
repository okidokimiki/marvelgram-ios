//
//  DetailPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

final class HeroDetailsPresenter {
    // MARK: - Properties
    
    weak var view: HeroDetailsViewInput?
    
    // MARK: - Private Properties
    
    private var dataSource: HeroDetailsDataSource?
    private var coordinator: HeroDetailsCoordinator
    
    // MARK: - Initilization
    
    required init(view: HeroDetailsViewInput, coordinator: HeroDetailsCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    
    func fillDataSource(with data: HeroDetailsDataSource?) {
        dataSource = data
    }
    
    // MARK: - Private Methods
    
    private func updateUI() {
        let model = dataSource?.heroSeleсtingCellModel
        view?.updateUI(with: model)
    }
}

// MARK: - DetailViewOutput

extension HeroDetailsPresenter: HeroDetailsViewOutput {
    func handleDidLayoutSubviews() {
        view?.finishLayoutSubviews()
    }
    
    func handleAppearingView() {
        updateUI()
    }
}
