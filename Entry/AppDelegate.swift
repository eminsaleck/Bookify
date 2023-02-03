//
//  AppDelegate.swift
//  Bookify
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import AppFeature
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container = DIContainer(appConfigurations: AppConfigurations())
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        print(AppConfigurations().apiBaseURL)
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = MainCoordinator(window: window!, container: container)
        coordinator?.start()
        
        
        return true
    }


}

