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

    // MARK: - UIViewController Lifecycle
    
    override func loadView() {
        let view = GalleryView()
        view.uiDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.handleDidAppearingView()
    }
}

// MARK: - GalleryViewUiDelegate

extension GalleryViewController: GalleryViewUiDelegate {
    func galleryView(_ galleryView: GalleryView, getHeroViewModelWithIndex index: Int) -> HeroViewModel? {
        return presenter?.getHeroViewModel(with: index)
    }
    
    func galleryViewCellsCount(_ galleryView: GalleryView) -> Int? {
        return presenter?.getHeroViewModelsCount()
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
