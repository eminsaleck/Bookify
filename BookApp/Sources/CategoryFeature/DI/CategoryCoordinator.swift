//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import UIKit

class CategoryCoordinator: NavigationCoordinator, CategoryCoordinatorProtocol {

    
    public var navigationController: UINavigationController

    private let dependencies: CategoryCoordinatorDependencies

    
    init(navigationController: UINavigationController, dependencies: CategoryCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func navigate(with state: CategoryState) {
        switch state {
        case .categoryFeatureInit:
            navigateToCategoryFeature()

        case .listIsPicked:
            navigateToList()
        }
    }
    
}

extension CategoryCoordinator{
    private func navigateToCategoryFeature() {
        let accountVC = dependencies.buildCategoryViewController(coordinator: self)
        navigationController.pushViewController(accountVC, animated: true)
    }
    
    private func navigateToList() {
     print("navigateToList")
    }
}
