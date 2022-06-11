//
//  GalleryPresenter.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import Foundation

class GalleryPresenter {
    // MARK: - Public Properties
    
    weak var view: GalleryViewProtocol?
    
    // MARK: - Private Properties
    
    private let heroesRepository = HeroesRepository.shared
    private var galleryDataSource: GalleryDataSource
    
    // MARK: - Initilization
    
    required init(
        view: GalleryViewProtocol,
        galleryDataSource: GalleryDataSource
    ) {
        self.view = view
        self.galleryDataSource = galleryDataSource
    }
    
    // MARK: - Private Methods
    
    private func fetchHeroesAndReloadCollectionView() {
        view?.showActivityIndicator(true)
        
        heroesRepository.getHeroes { [unowned self] heroes in
            let models = heroes.map { HeroModel(hero: $0) }
            self.galleryDataSource.heroModels = models
            
            DispatchQueue.main.async {
                self.view?.showActivityIndicator(false)
                self.view?.reloadHeroesCollectionView()
            }
        }
    }
}

// MARK: - GalleryPresenterProtocol

extension GalleryPresenter: GalleryPresenterProtocol {
    func handleDidAppearingView() {
        fetchHeroesAndReloadCollectionView()
    }
    
    func getHeroModelsCount() -> Int? {
        return galleryDataSource.heroModels.count
    }
    
    func getHeroModel(with index: Int) -> HeroModel {
        return galleryDataSource.heroModels[index]
    }
}
