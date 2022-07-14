//
//  AppCoordinator.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 29.06.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Private Properties
    
    private let window: UIWindow?
    private var navigationController: UINavigationController
    private(set) var childCoordinators: [Coordinator] = []
    
    // MARK: - Initilization
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    // MARK: - Methods
    
    func start() {
        configureWindow()
        // HeroesList
        let heroesListCoordinator = HeroesListCoordinator(navigationController: navigationController)
        heroesListCoordinator.start()
        
        childCoordinators.append(heroesListCoordinator)
    }
    
    // MARK: - Private Methods
    
    private func configureWindow() {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .dark
        }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
