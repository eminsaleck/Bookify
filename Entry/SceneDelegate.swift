//
//  SceneDelegate.swift
//  Books
//
//  Created by LEMIN DAHOVICH on 02.02.2023.
//

import UIKit
import AppFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let container = DIContainer(appConfigurations: AppConfigurations())
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        coordinator = MainCoordinator(window: window!, container: container)
        coordinator?.start()

    }

}
