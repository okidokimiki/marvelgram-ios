//
//  MainViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: MainViewOutput?
    
    // MARK: - Private Properties
    
    private lazy var marvelButton = MarvelBarButtonItem()
    
    // MARK: - UIViewController Lifecycle
    
    override func loadView() {
        let view = MainView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.handleDidAppearingView()
    }
    
    // MARK: - Private Methods
    
    private func setupNavController() {
        navigationItem.leftBarButtonItem = marvelButton
    }
}

// MARK: - MainViewUiDelegate

extension MainViewController: MainViewUiDelegate {
    func mainView(_ mainView: MainView, getHeroCellModelWithIndex index: Int) -> HeroSeleсtingCellModel? {
        return presenter?.getHeroCellModel(with: index)
    }
    
    func mainViewCellsCount(_ mainView: MainView) -> Int? {
        return presenter?.getHeroCellModelsCount()
    }
    
    func mainView(_ mainView: MainView, didSelectHeroWithIndex index: IndexPath) {
        presenter?.handleSelectingHeroCell(with: index.row)
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func reloadHeroesCollectionView() {
        guard let mainView = view as? MainView else { return }
        mainView.reloadHeroesCollectionView()
    }
    
    func showActivityIndicator(_ show: Bool) {
        guard let mainView = view as? MainView else { return }
        mainView.showActivityIndicator(show)
    }
}
