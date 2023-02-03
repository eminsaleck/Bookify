//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import UIKit

final public  class DIContainer {
    
    private let dependencies: FeatureDependencies
    
    private var categoryViewModel: CategoryViewModel?

    
    init(dependencies: FeatureDependencies) {
        self.dependencies = dependencies
    }
}

extension DIContainer{
    func buildModuleCoordinator(navigationController: UINavigationController) -> Coordinator {
        return CategoryCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DIContainer: CategoryCoordinatorDependencies {
    
    func buildCategoryViewController(coordinator: CategoryCoordinatorProtocol?) -> UIViewController {
        return CategoryViewController()
    }
}
