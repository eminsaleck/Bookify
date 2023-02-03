//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit
import Common
import UI


public enum SignedChildCoordinator {
    case category
}

public class SignedCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    private var childCoordinators = [SignedChildCoordinator: Coordinator]()
    private let DIContainer: DIContainer
    
    
    public init(tabBarController: UITabBarController, DIContainer: DIContainer) {
        self.tabBarController = tabBarController
        self.DIContainer = DIContainer
    }
    
    public func start() {
        showMainFeatures()
    }
    
    fileprivate func showMainFeatures() {
        let categoryNavigation = UINavigationController()
        categoryNavigation.tabBarItem = UITabBarItem(title: Localized.mainScreen.localized(),
                                                    image: UIImage(named: "category"), tag: 3)
       buildCategoryCoordinator(in: categoryNavigation)

        tabBarController.setViewControllers([categoryNavigation], animated: true)
    }
}

extension SignedCoordinator {
    
    private func buildCategoryCoordinator(in navigation: UINavigationController) {
        let categoryModule = DIContainer.buildCategoryModule()
        let coordinator = categoryModule.buildCategoryCoordinator(in: navigation)
        coordinator.start()
        childCoordinators[.category] = coordinator
    }
}
