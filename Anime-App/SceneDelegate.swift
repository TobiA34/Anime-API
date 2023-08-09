//
//  SceneDelegate.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let animeVC = ViewController()
            let navigation = UINavigationController(rootViewController: animeVC)
            window.rootViewController = navigation
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
