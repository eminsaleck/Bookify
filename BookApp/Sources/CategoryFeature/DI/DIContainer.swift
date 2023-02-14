//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import UIKit
import CollectionFeatureInterface

final public  class DIContainer {
    
    private let dependencies: FeatureDependencies
    
    private lazy var categoryRepository: CategoryRepository = {
      return DefaultCategoryRepository(
        remoteDataSource: DefaultCategoryRemoteDataSource(dataTransferService: dependencies.apiDataTransferService),
        localDataSource: dependencies.localStorage
      )
    }()
    
    init(dependencies: FeatureDependencies) {
        self.dependencies = dependencies
        
    }
    
    private func makeFetchCategoryUseCase() -> FetchCategoryUseCase {
        return DefaultFetchGenresUseCase(categoryRepository: categoryRepository)
    }
}

extension DIContainer{
    func buildModuleCoordinator(navigationController: UINavigationController) -> Coordinator {
        return CategoryCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DIContainer: CategoryCoordinatorDependencies {
    func buildCollectionCoordinator(navigationController: UINavigationController, delegate: CollectionCoordinatorDelegate?) -> CollectionCoordinatorProtocol {
        return dependencies.collectionBuilder.buildModuleCoordinator(in: navigationController, delegate: delegate)
    }
    
    
    func buildCategoryViewController(coordinator: CategoryCoordinatorProtocol?) -> UIViewController {
         
        let categoryViewModel = CategoryViewModel(useCase: makeFetchCategoryUseCase())
        categoryViewModel.coordinator = coordinator
        
        let categoryVC = CategoryViewController(viewModel: categoryViewModel)
        return categoryVC
    }
}
