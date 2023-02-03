//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit
import Common
//import ListFeatureInterface

protocol CategoryCoordinatorProtocol: AnyObject {
    func navigate(with state: CategoryState)
}

public enum CategoryState: State {
    case categoryFeatureInit
    case categoryIsPicked(published: String, listName: String)
}

protocol CategoryCoordinatorDependencies {
    func buildCategoryViewController(coordinator: CategoryCoordinatorProtocol?) -> UIViewController
//    func buildListCoordinator(navigationController: UINavigationController,
//                              delegate: ListCoordinatorDelegate?) -> ListCoordinatorProtocol
}

public enum CategoryChildCoordinator {
    case categoryList
}
