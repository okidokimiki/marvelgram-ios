//
//  DetailViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: DetailViewOutput?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = DetailView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - DetailViewUiDelegate

extension DetailViewController: DetailViewUiDelegate {
}

// MARK: - DetailViewInput

extension DetailViewController: DetailViewInput {
}
