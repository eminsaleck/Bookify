//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import UIKit
import UI
import CollectionFeatureInterface

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

extension CategoryCoordinator {
    private func navigateToCategoryFeature() {
        let categoryVC = dependencies.buildCategoryViewController(coordinator: self)
        categoryVC.navigationItem.title = Localized.nyt.localized()
        navigationController.pushViewController(categoryVC, animated: true)
    }
    // MARK: - Navigate to List
    private func navigateToList(published: String, listName: String) {
      let collectionCoordinator = dependencies
            .buildCollectionCoordinator(navigationController: navigationController, delegate: self)
        childCoordinators[.collection] = collectionCoordinator
      let nextState = CollectionState.bookList(published: published, listName: listName)
        collectionCoordinator.navigate(with: nextState)
    }
}

extension CategoryCoordinator: CategoryViewModelDelegate {
    func categoryViewModel(_ categoryViewModel: CategoryViewModel,
                           didCategoryPicked listName: String, published: String) {
        print(listName)
        navigate(with: .categoryIsPicked(published: published, listName: listName))
    }
}
extension CategoryCoordinator: CollectionCoordinatorDelegate {
    public func collectionCoordinatorDidFinish() {
        childCoordinators[.collection] = nil
    }
}
