//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Common
import CollectionFeatureInterface

final class DIContainer {
    private let dependencies: CollectionFeatureInterface.FeatureDependencies

    init(dependencies: CollectionFeatureInterface.FeatureDependencies) {
      self.dependencies = dependencies
    }
    
    func buildModuleCoordinator(navigationController: UINavigationController,
                                delegate: CollectionCoordinatorDelegate?) -> CollectionCoordinatorProtocol {
      let coordinator =  CollectionCoordinator(navigationController: navigationController, dependencies: self)
      coordinator.delegate = delegate
      return coordinator
    }

}
extension DIContainer: CollectionCoordinatorDependencies {
    func buildcollectionViewController_ForCategory(with published: String, listName: String, coordinator: CollectionFeatureInterface.CollectionCoordinatorProtocol) -> UIViewController {
        return UIViewController(nibName: nil, bundle: nil)
    }
}

