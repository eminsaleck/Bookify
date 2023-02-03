//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit
import Common

public struct Module {

  private let diContainer: DIContainer

  public init(dependencies: FeatureDependencies) {
    self.diContainer = DIContainer(dependencies: dependencies)
  }

  public func buildCategoryCoordinator(in navigationController: UINavigationController) -> Coordinator {
    return diContainer.buildModuleCoordinator(navigationController: navigationController)
  }
}
