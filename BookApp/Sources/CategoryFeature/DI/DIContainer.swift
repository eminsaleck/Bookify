//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import UIKit

final class DIContainer {
    
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
        guard let categoryViewModel = categoryViewModel else { return UIViewController(nibName: nil, bundle: nil) }
        categoryViewModel.coordinator = coordinator
        return CategoryViewController()
    }
}
