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
    
    private let networkManager = NetworkManager.shared
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
        
        networkManager.fetchHeroes { result in
            switch result {
            case .success(let heroesData):
                let viewModels = heroesData.map { HeroViewModel(hero: $0) }
                self.galleryDataSource.heroViewModel = viewModels
                
                DispatchQueue.main.async {
                    self.view?.showActivityIndicator(false)
                    self.view?.reloadHeroesCollectionView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - GalleryPresenterProtocol

extension GalleryPresenter: GalleryPresenterProtocol {
    func handleDidAppearingView() {
        fetchHeroesAndReloadCollectionView()
    }
    
    func getHeroViewModelsCount() -> Int? {
        return galleryDataSource.heroViewModel.count
    }
    
    func getHeroViewModel(with index: Int) -> HeroViewModel {
        return galleryDataSource.heroViewModel[index]
    }
}
