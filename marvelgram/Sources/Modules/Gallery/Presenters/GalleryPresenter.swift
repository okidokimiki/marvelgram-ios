//
//  GalleryPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

class GalleryPresenter {
    // MARK: - Public Properties
    
    weak var view: GalleryViewInput?
    
    // MARK: - Private Properties
    
    private let heroesRepository = HeroesRepository.shared
    private var galleryDataSource: GalleryDataSource
    
    // MARK: - Initilization
    
    required init(
        view: GalleryViewInput,
        galleryDataSource: GalleryDataSource
    ) {
        self.view = view
        self.galleryDataSource = galleryDataSource
    }
    
    // MARK: - Private Methods
    
    private func fetchHeroesAndReloadCollectionView() {
        view?.showActivityIndicator(true)

        heroesRepository.getHeroes { [weak self] heroes in
            guard let self = self else { return }

            let models = heroes.map { HeroCellModel(hero: $0) }
            self.galleryDataSource.heroCellModels = models

            DispatchQueue.main.async {
                self.view?.showActivityIndicator(false)
                self.view?.reloadHeroesCollectionView()
            }
        }
    }
}

// MARK: - GalleryViewOutput

extension GalleryPresenter: GalleryViewOutput {
    func handleDidAppearingView() {
        fetchHeroesAndReloadCollectionView()
    }
    
    func getHeroCellModelsCount() -> Int? {
        return galleryDataSource.heroCellModels.count
    }
    
    func getHeroCellModel(with index: Int) -> HeroCellModel {
        return galleryDataSource.heroCellModels[index]
    }
}
