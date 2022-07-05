//
//  DetailViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 09.06.2022.
//

import UIKit

final class HeroDetailsViewController: UIViewController {
    // MARK: - Properties
    
    var presenter: HeroDetailsViewOutput?
    
    // MARK: - Private Properties
    
    private var heroDetailsView: HeroDetailsView {
        guard let castedView = view as? HeroDetailsView else {
            fatalError("TypeCasting Error: presenterView must be \(HeroDetailsView.self)")
        }
        
        return castedView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let view = HeroDetailsView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.handleDidLoadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.handleAppearingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presenter?.handleDidLayoutSubviews()
    }
}

// MARK: - DetailViewUiDelegate

extension HeroDetailsViewController: HeroDetailsViewUiDelegate {
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getOtherCharCellModelWithIndex index: Int) -> HeroSeleсtingCellModel? {
        return presenter?.getOtherCharCellModel(with: index)
    }
    
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getCellsCountOf reuseIdentifier: String) -> Int? {
        return presenter?.getOtherCharCellsCount()
    }
}

// MARK: - DetailViewInput

extension HeroDetailsViewController: HeroDetailsViewInput {
    func reloadCollectionView() {
        heroDetailsView.reloadCollectionView()
    }
    
    func updateUI(with model: HeroSeleсtingCellModel?) {
        heroDetailsView.updateUI(with: model)
    }
    
    func finishLayoutSubviews() {
        heroDetailsView.finishLayoutSubviews()
    }
}
