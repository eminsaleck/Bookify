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
    private var childCoordinators = [CategoryChildCoordinator: Coordinator]()
    
    
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
            
        case .categoryIsPicked(published: let date, listName: let name):
            navigateToList(published: date, listName: name)
        }
    }
    
}

extension CategoryCoordinator{
    private func navigateToCategoryFeature() {
        let categoryVC = dependencies.buildCategoryViewController(coordinator: self)
        navigationController.pushViewController(categoryVC, animated: true)
    }
    
    
    // MARK: - Navigate to List
    private func navigateToList(published: String, listName: String) {
        print("\(published), \(listName)")
    }
}

//
//extension CategoryCoordinator: ListCoordinatorDelegate {
//  public func listCoordinatorDidFinish() {
//      childCoordinators[.categoryList] = nil
//  }
//}
