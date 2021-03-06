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
    
    private lazy var backButton: BackBarButtonItem = {
        return BackBarButtonItem()
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.handleWillAppearingView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presenter?.handleDidLayoutSubviews()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        let view = HeroDetailsView()
        view.uiDelegate = self
        self.view = view
    }
    
    private func setupNavController(with model: HeroCellModel?) {
        let appearance = UINavigationBar.appearance()
        let attributes = [
            NSAttributedString.Key.font: AppFont.SFPro.regular17,
            NSAttributedString.Key.foregroundColor: AppColor.GlobalColor.font
        ]
        
        title = model?.name
        appearance.titleTextAttributes = attributes
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

// MARK: - UiDelegate

extension HeroDetailsViewController: HeroDetailsViewUiDelegate {
    // Actions
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, didSelectCharWithIndexPath indexPath: IndexPath) {
        presenter?.handleDidSelectingCharCell(with: indexPath)
    }
    
    // DataSource
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getOtherCharCellModelWithIndexPath indexPath: IndexPath) -> HeroCellModel? {
        return presenter?.getOtherCharCellModel(with: indexPath)
    }
    
    func heroDetailsView(_ heroDetailsView: HeroDetailsView, getCellsCountOf reuseIdentifier: String) -> Int? {
        return presenter?.getOtherCharCellsCount()
    }
}

// MARK: - ViewInput

extension HeroDetailsViewController: HeroDetailsViewInput {
    func updateUI(with model: HeroCellModel?) {
        setupNavController(with: model)
        heroDetailsView.updateUI(with: model)
    }
    
    func finishLayoutSubviews() {
        heroDetailsView.finishLayoutSubviews()
    }
}
