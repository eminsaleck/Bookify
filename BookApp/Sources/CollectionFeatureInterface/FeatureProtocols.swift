//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Common


public protocol ModuleCollectionBuilder {
  func buildModuleCoordinator(in navigationController: UINavigationController,
                              delegate: CollectionCoordinatorDelegate?) -> CollectionCoordinatorProtocol
}

public protocol CollectionCoordinatorProtocol: NavigationCoordinator {
  func navigate(with state: CollectionState)
}

public protocol CollectionCoordinatorDelegate: AnyObject {
  func collectionCoordinatorDidFinish()
}

// MARK: - states
public enum CollectionState: State {
  case bookList(published: String, listName: String)
  case collectionDidFinish
}
