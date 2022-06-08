//
//  ProfilePresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import Foundation

class ProfilePresenter {
    // MARK: - Public Properties
    
    weak var view: ProfileViewProtocol?
    
    // MARK: - Initilization
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
}

// MARK: - ProfilePresenterProtocol

extension ProfilePresenter: ProfilePresenterProtocol {
}
