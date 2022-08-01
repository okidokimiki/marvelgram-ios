import UIKit

typealias HeroesHandler = ([Hero]) -> Void

final class HeroesRepository {
    
    private let fileManagerDirURLs = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    private let networkService: Networkable
    
    private var heroes: [Hero] = []
    private var heroesConfigDestURL: URL? {
        let appSupportDirURL = fileManagerDirURLs.last
        let folderURL = appSupportDirURL?.appendingPathComponent(Constants.folderName, isDirectory: true)
        let fullFileName = Constants.fileName + "." + Constants.fileExtension
        let destURL = folderURL?.appendingPathComponent(fullFileName)
        
        return destURL
    }
    
    init(networkService: Networkable) {
        self.networkService = networkService
        heroes = readHeroes(from: heroesConfigDestURL)
    }
    
    func getHeroes(completion: @escaping HeroesHandler) {
        networkService.fetchConfig(with: API.upstartsMarvelgram, of: [Hero].self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let config):
                guard let configURL = config as? URL else { return }
                let newHeroes = self.readHeroes(from: configURL)
                
                guard newHeroes != self.heroes else {
                    completion(self.heroes)
                    return
                }
                
                self.saveFile(from: configURL, to: Constants.folderName)
                self.heroes = newHeroes
                
            case .failure(let netError):
                print(netError.localizedDescription)
            }
            
            completion(self.heroes)
        }
    }
    
    func getHeroesRandomly(count: Int = Constants.countOfRandomHeroes) -> [Hero]? {
        guard !heroes.isEmpty, count <= heroes.count else { return nil }
        
        var uniqueRandomNumbers: Set<Int> = []
        var array: [Hero] = []

        while uniqueRandomNumbers.count < count {
            let value = Int.random(in: 0..<heroes.count)
            uniqueRandomNumbers.insert(value)
        }
        
        uniqueRandomNumbers.forEach { array.append(heroes[$0]) }
        
        return array
    }
    
    private func readHeroes(from url: URL?) -> [Hero] {
        guard let destURL = url, fileManager.fileExists(atPath: destURL.path) else { return heroes }
        
        do {
            let data = try Data(contentsOf: destURL, options: .mappedIfSafe)
            let decodedData = try decoder.decode([Hero].self, from: data)
            
            return decodedData
        } catch {
            print(error.localizedDescription)
        }
        
        
        return heroes
    }
    
    private func saveFile(from srcURL: URL, to folder: String) {
        guard let destURL = heroesConfigDestURL else { return }
        
        createApplicationSupportDirectoryIfNeeded(with: folder)
        guard !fileManager.fileExists(atPath: destURL.path) else {
            do {
                try fileManager.removeItem(at: destURL)
            } catch {
                print(error.localizedDescription)
            }
            return
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
    
    // MARK: - Constants
    
    enum Constants {
        static let countOfRandomHeroes = 10
        static let folderName = "Marvelgram"
        static let fileName = "heroes"
        static let fileExtension = "json"
    }
}
