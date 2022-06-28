//
//  GalleryViewController.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

final class GalleryViewController: UIViewController {
    // MARK: - Public Properties
    
    var presenter: GalleryViewOutput?
    
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
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.handleDidAppearingView()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        navigationItem.leftBarButtonItem = marvelButton
    }
}

// MARK: - GalleryViewUiDelegate

extension GalleryViewController: GalleryViewUiDelegate {
    func galleryView(_ galleryView: GalleryView, getHeroCellModelWithIndex index: Int) -> HeroCellModel? {
        return presenter?.getHeroCellModel(with: index)
    }
    
    func galleryViewCellsCount(_ galleryView: GalleryView) -> Int? {
        return presenter?.getHeroCellModelsCount()
    }
}

// MARK: - GalleryViewInput

extension GalleryViewController: GalleryViewInput {
    func reloadHeroesCollectionView() {
        guard let galleryView = view as? GalleryView else { return }
        galleryView.reloadHeroesCollectionView()
    }
    
    func showActivityIndicator(_ show: Bool) {
        guard let galleryView = view as? GalleryView else { return }
        galleryView.showActivityIndicator(show)
    }
}
