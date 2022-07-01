//
//  DetailViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

final class HeroDetailsViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: HeroDetailsViewOutput?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = HeroDetailsView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - DetailViewUiDelegate

extension HeroDetailsViewController: HeroDetailsViewUiDelegate {
}

// MARK: - DetailViewInput

extension HeroDetailsViewController: HeroDetailsViewInput {
}
