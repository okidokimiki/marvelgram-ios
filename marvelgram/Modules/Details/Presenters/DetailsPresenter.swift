//
//  DetailsPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

class DetailsPresenter {
    // MARK: - Public Properties
    
    weak var view: DetailsViewProtocol?
    
    // MARK: - Initilization
    
    required init(view: DetailsViewProtocol) {
        self.view = view
    }
}

// MARK: - DetailsPresenterProtocol

extension DetailsPresenter: DetailsPresenterProtocol {
}
