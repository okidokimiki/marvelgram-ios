//
//  GalleryViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class GalleryViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: GalleryPresenterProtocol?
    
    // MARK: - Private Properties
    
    private lazy var marvelButton = MarvelBarButtonItem()
    
    // MARK: - UIViewController Lifecycle
    
    override func loadView() {
        let view = GalleryView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.handleDidAppearingView()
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = marvelButton
    }
}

// MARK: - GalleryViewUiDelegate

extension GalleryViewController: GalleryViewUiDelegate {
    func galleryView(_ galleryView: GalleryView, getHeroModelWithIndex index: Int) -> HeroModel? {
        return presenter?.getHeroModel(with: index)
    }
    
    func galleryViewCellsCount(_ galleryView: GalleryView) -> Int? {
        return presenter?.getHeroModelsCount()
    }
}

// MARK: - GalleryViewProtocol

extension GalleryViewController: GalleryViewProtocol {
    func reloadHeroesCollectionView() {
        guard let galleryView = view as? GalleryView else { return }
        galleryView.reloadHeroesCollectionView()
    }
    
    func showActivityIndicator(_ show: Bool) {
        guard let galleryView = view as? GalleryView else { return }
        galleryView.showActivityIndicator(show)
    }
}
