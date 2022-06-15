//
//  DetailsViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: DetailsPresenterProtocol?
    
    // MARK: - UIViewController Lifecycle
    
    override func loadView() {
        let view = DetailsView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - DetailsViewUiDelegate

extension DetailsViewController: DetailsViewUiDelegate {
}

// MARK: - DetailsViewProtocol

extension DetailsViewController: DetailsViewProtocol {
}
