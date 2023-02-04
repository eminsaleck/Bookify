//
//  AppDelegate.swift
//  Entry
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGlobalAppearanceIfNeeded()
        return true
    }
}


extension AppDelegate{
    
    func configureGlobalAppearanceIfNeeded(){
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            guard let font = UIFont(name: "Avenir-Book", size: 17) else {
                fatalError()
            }
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: font]
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
        }
    }
}
