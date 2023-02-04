//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import UI
import Common
import CollectionFeatureInterface

public class CollectionCoordinator: CollectionCoordinatorProtocol {

    
    public var navigationController: UINavigationController
    
    public weak var delegate: CollectionCoordinatorDelegate?
    
    private let dependencies: CollectionCoordinatorDependencies
    
    
    init(navigationController: UINavigationController,
         dependencies: CollectionCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func navigate(with state: CollectionState) {
        switch state {
        case .bookList(published: let date, listName: let name):
            navigateToCategoryList(with: date, listName: name)
        case .collectionDidFinish:
          delegate?.collectionCoordinatorDidFinish()
        }
    }
    
    public func start(with state: CollectionState) {
     navigate(with: state)
    }
    
    private func navigateToCategoryList(with published: String, listName: String) {
        let viewController = dependencies.buildcollectionViewController_ForCategory(with: published, listName: listName, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
      }
    
}
