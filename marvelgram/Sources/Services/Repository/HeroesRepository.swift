//
//  HeroesRepository.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

final class HeroesRepository: HeroesRepositorieble {
    // MARK: - Private Properties
    
    private let fileManagerDirURLs = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    
    private let networkService: Networkable
    private var heroes: [Hero] = []
    
    // MARK: - Initilization
    
    init(networkService: Networkable) {
        self.networkService = networkService
        let destURL = getHeroesConfigDestURL()
        heroes = makeHeroes(from: destURL)
    }
    
    // MARK: - Methods
    
    func getHeroes(completion: @escaping HeroConfigResponseHandler) {
        networkService.fetchConfig(with: API.upstartsMarvelgram, of: [Hero].self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let config):
                guard let configUrl = config as? URL else { return }
                let newHeroes = self.makeHeroes(from: configUrl)
                
                if newHeroes != self.heroes {
                    self.saveFile(from: configUrl, to: Constants.folderName)
                    self.heroes = newHeroes
                }
            case .error(let netError):
                print(netError.localizedDescription)
            }
            
            completion(self.heroes)
        }
    }
        
    // MARK: - Private Methods
    
    private func getHeroesConfigDestURL() -> URL? {
        let appSupportDirURL = fileManagerDirURLs.last
        let folderURL = appSupportDirURL?.appendingPathComponent(Constants.folderName, isDirectory: true)
        let fullFileName = Constants.fileName + "." + Constants.fileExtension
        let destURL = folderURL?.appendingPathComponent(fullFileName)
        
        return destURL
    }
    
    private func makeHeroes(from url: URL?) -> [Hero] {
        guard let destURL = url else { return heroes }
        
        if fileManager.fileExists(atPath: destURL.path) {
            do {
                let data = try Data(contentsOf: destURL, options: .mappedIfSafe)
                let decodedData = try decoder.decode([Hero].self, from: data)
                
                return decodedData
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return heroes
    }
    
    private func saveFile(from srcURL: URL, to folder: String) {
        guard let destURL = getHeroesConfigDestURL() else { return }
        
        createApplicationSupportDirectoryIfNeeded(with: folder)
        if fileManager.fileExists(atPath: destURL.path) {
            do {
                try fileManager.removeItem(at: destURL)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        do {
            try fileManager.copyItem(atPath: srcURL.path, toPath: destURL.path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createApplicationSupportDirectoryIfNeeded(with folder: String) {
        guard let appSupportDirURL = fileManagerDirURLs.last else { return }
        
        let folderURL = appSupportDirURL.appendingPathComponent(folder)
        guard !fileManager.fileExists(atPath: folderURL.path) else { return }
        
        do {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Constants

private extension HeroesRepository {
    enum Constants {
        static let folderName = "Heroes"
        static let fileName = "heroes"
        static let fileExtension = "json"
    }
}
