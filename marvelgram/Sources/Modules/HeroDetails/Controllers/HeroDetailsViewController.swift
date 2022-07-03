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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.handleAppearingView()
    }
}

// MARK: - DetailViewUiDelegate

extension HeroDetailsViewController: HeroDetailsViewUiDelegate {
}

// MARK: - DetailViewInput

extension HeroDetailsViewController: HeroDetailsViewInput {
    func updateUI(with model: HeroSeleсtingCellModel?) {
        guard let heroDetailsView = view as? HeroDetailsView else { return }
        heroDetailsView.updateUI(with: model)
    }
    
}
