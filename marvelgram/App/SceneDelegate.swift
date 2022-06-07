//
//  SceneDelegate.swift
//  marvelgram
//
//  Created by Mikhail Chaus on 07.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - UIWindowSceneDelegate
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = GalleryViewModuleBuilder.createModule()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = viewController
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
    }
}
