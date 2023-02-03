//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import UIKit

public class CategoryCoordinator: NavigationCoordinator, CategoryCoordinatorProtocol {

    
    public var navigationController: UINavigationController

    private let dependencies: CategoryCoordinatorDependencies

    
    init(navigationController: UINavigationController, dependencies: CategoryCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() {
        navigate(with: .categoryFeatureInit)
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
        
        let categoryVC = dependencies.buildCategoryViewController(coordinator: self)
       
     navigationController.pushViewController(categoryVC, animated: true)
        
    }
    
    private func navigateToList() {
     print("navigateToList")
    }
}
