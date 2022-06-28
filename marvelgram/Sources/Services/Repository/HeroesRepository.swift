//
//  HeroesRepository.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

final class HeroesRepository {
    // MARK: - Public Properties
    
    static let shared = HeroesRepository()
    
    // MARK: - Private Properties
    
    private let fileManagerDirUrls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    
    private let networkService = NetworkService.shared
    private var heroes: [Hero] = []
    
    // MARK: - Initilization
    
    private init() {
        let destURL = getHeroesConfigDestURL()
        heroes = makeHeroesFromConfig(with: destURL)
    }
        
    // MARK: - Private Methods
    
    private func getHeroesConfigDestURL() -> URL? {
        let appSupportDirURL = fileManagerDirUrls.last
        let folderURL = appSupportDirURL?.appendingPathComponent(Constants.folderName, isDirectory: true)
        let fullFileName = Constants.fileName + "." + Constants.fileExtension
        let destURL = folderURL?.appendingPathComponent(fullFileName)
        
        return destURL
    }
    
    private func makeHeroesFromConfig(with url: URL?) -> [Hero] {
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
        createApplicationSupportDirectoryIfNeeded(with: folder)
        guard let destURL = getHeroesConfigDestURL() else { return }
        print(destURL.path)
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
        guard let appSupportDirURL = fileManagerDirUrls.last else { return }
        let folderURL = appSupportDirURL.appendingPathComponent(folder)
        guard !fileManager.fileExists(atPath: folderURL.path) else { return }
        do {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - HeroesRepositorieble

extension HeroesRepository: HeroesRepositorieble {
    func getHeroes(completion: @escaping HeroConfigResponseHandler) {
        networkService.fetchHeroesConfig { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let config):
                guard let configUrl = config as? URL else { return }
                let newHeroes = self.makeHeroesFromConfig(with: configUrl)
                
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
}

// MARK: - Constants

private extension HeroesRepository {
    enum Constants {
        static let folderName = "Heroes"
        static let fileName = "heroes"
        static let fileExtension = "json"
    }
}
