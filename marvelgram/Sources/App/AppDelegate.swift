//
//  AppDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        
        appCoordinator.start()
        return true
    }
}
