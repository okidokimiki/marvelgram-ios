//
//  ProfileViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: ProfilePresenterProtocol?
    
    // MARK: - UIViewController Lifecycle
    
    override func loadView() {
        let view = ProfileView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - ProfileViewUiDelegate

extension ProfileViewController: ProfileViewUiDelegate {
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
}
