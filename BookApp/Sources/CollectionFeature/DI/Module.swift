//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Common
import CollectionFeatureInterface

public struct Module: ModuleCollectionBuilder {

  private let diContainer: DIContainer

  public init(dependencies: FeatureDependencies) {
    self.diContainer = DIContainer(dependencies: dependencies)
  }

  public func buildModuleCoordinator(in navigationController: UINavigationController,
                                     delegate: CollectionCoordinatorDelegate?) -> CollectionCoordinatorProtocol {
    return diContainer.buildModuleCoordinator(navigationController: navigationController, delegate: delegate)
  }
}
