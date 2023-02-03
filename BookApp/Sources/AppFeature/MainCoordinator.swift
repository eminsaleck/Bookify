//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import UIKit


public enum AppChildCoordinator {
    case category
}

public class MainCoordinator: Coordinator {
    
    private let window: UIWindow
    private var childCoordinators = [AppChildCoordinator: Coordinator]()
    private let container: DIContainer
    
    // MARK: - Initializer
    public init(window: UIWindow, container: DIContainer) {
        self.window = window
        self.container = container
    }
    
    public func start() {
        navigateToCategoryFlow()
    }
    
    fileprivate func navigateToCategoryFlow() {
        
        let categoryNavigation = UINavigationController()
        buildCategoryCoordinator(in: categoryNavigation)
        
        self.window.rootViewController = categoryNavigation
        self.window.makeKeyAndVisible()
    }
}


extension MainCoordinator {
    
    private func buildCategoryCoordinator(in navigation: UINavigationController) {
        let categoryModule = container.buildCategoryModule()
        let coordinator = categoryModule.buildCategoryCoordinator(in: navigation)
        coordinator.start()
        childCoordinators[.category] = coordinator
    }
}
