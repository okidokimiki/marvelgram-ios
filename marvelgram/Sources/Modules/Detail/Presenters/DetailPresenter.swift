//
//  DetailsPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

class DetailPresenter {
    // MARK: - Public Properties
    
    weak var view: DetailViewInput?
    
    // MARK: - Initilization
    
    required init(view: DetailViewInput) {
        self.view = view
    }
}

// MARK: - DetailsPresenterProtocol

extension DetailPresenter: DetailViewOutput {
}
