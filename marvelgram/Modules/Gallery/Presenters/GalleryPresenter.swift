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
            let models = heroes.map { HeroCellModel(hero: $0) }
            self.galleryDataSource.heroCellModels = models
            
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
    
    func getHeroCellModelsCount() -> Int? {
        return galleryDataSource.heroCellModels.count
    }
    
    func getHeroCellModel(with index: Int) -> HeroCellModel {
        return galleryDataSource.heroCellModels[index]
    }
}
