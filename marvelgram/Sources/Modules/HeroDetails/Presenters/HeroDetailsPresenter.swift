//
//  DetailPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

final class HeroDetailsPresenter {
    // MARK: - Public Properties
    
    weak var view: HeroDetailsViewInput?
    
    // MARK: - Private Properties
    
    private var dataSource: HeroDetailsDataSource?
    private var coordinator: HeroDetailsCoordinator
    
    // MARK: - Initilization
    
    required init(view: HeroDetailsViewInput, coordinator: HeroDetailsCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    // MARK: - Public Methods
    
    func fillDataSource(with data: HeroDetailsDataSource?) {
        dataSource = data
    }
}

// MARK: - DetailViewOutput

extension HeroDetailsPresenter: HeroDetailsViewOutput {
}
