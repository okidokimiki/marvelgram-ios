//
//  HeroesRepository.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 08.06.2022.
//

import UIKit

class HeroesRepository {
    // MARK: - Public Properties
    
    static let shared = HeroesRepository()
    
    // MARK: - Private Properties
    
    private let networkManager = NetworkManager.shared
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    
    private var heroes: [Hero] = []
    
    private enum Constants {
        static let folderName = "Heroes"
        static let fileName = "heroes"
        static let fileExtension = "json"
    }
    
    // MARK: - Initilization
    
    private init() {
        let destURL = getHeroesConfigDestURL()
        heroes = makeHeroesFromConfig(at: destURL)
    }
    
    // MARK: - Public Methods
    
    func getHeroes(completion: @escaping ([Hero]) -> Void) {
        networkManager.fetchHeroesConfig { result in
            switch result {
            case .success(let urlFile):
                let newHeroesConfig = self.makeHeroesFromConfig(at: urlFile)
                
                if newHeroesConfig != self.heroes {
                    self.saveFile(from: urlFile, to: Constants.folderName)
                    self.heroes = newHeroesConfig
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            completion(self.heroes)
        }
    }
    
    // MARK: - Private Methods
    
    private func getHeroesConfigDestURL() -> URL? {
        let appSupportDirURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
        let folderURL = appSupportDirURL?.appendingPathComponent(Constants.folderName, isDirectory: true)
        let fullFileName = Constants.fileName + "." + Constants.fileExtension
        let destURL = folderURL?.appendingPathComponent(fullFileName)
        
        return destURL
    }
    
    private func makeHeroesFromConfig(at url: URL?) -> [Hero] {
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
        createApplicationSupportDirectoryWithFolderIfNeeded(folder)
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
    
    private func createApplicationSupportDirectoryWithFolderIfNeeded(_ folder: String) {
        guard
            let appSupportDirURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
        else { return }
        let folderURL = appSupportDirURL.appendingPathComponent(folder)
        guard !fileManager.fileExists(atPath: folderURL.path) else { return }
        do {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
