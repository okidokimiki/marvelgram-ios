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
    
    // MARK: - Initilization
    
    required init(view: HeroDetailsViewInput) {
        self.view = view
    }
    
    // MARK: - Public Methods
    
    func fillDataSource(with data: HeroDetailsDataSource?) {
        dataSource = data
    }
}

// MARK: - DetailViewOutput

extension HeroDetailsPresenter: HeroDetailsViewOutput {
}
