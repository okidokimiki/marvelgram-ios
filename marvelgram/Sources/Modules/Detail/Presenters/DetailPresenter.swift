//
//  DetailPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

final class DetailPresenter {
    // MARK: - Public Properties
    
    weak var view: DetailViewInput?
    
    // MARK: - Private Properties
    
    private var dataSource: DetailDataSource
    
    // MARK: - Initilization
    
    required init(
        view: DetailViewInput,
        dataSource: DetailDataSource
    ) {
        self.view = view
        self.dataSource = dataSource
    }
}

// MARK: - DetailViewOutput

extension DetailPresenter: DetailViewOutput {
}
