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
    
    private lazy var categoryRepository: CategoryRepository = {
      return DefaultCategoryRepository(
        remoteDataSource: DefaultCategoryRemoteDataSource(dataTransferService: dependencies.apiDataTransferService)
      )
    }()
    
    init(dependencies: FeatureDependencies) {
        self.dependencies = dependencies
        
    }
    
    private func makeFetchGenresUseCase() -> FetchCategoryUseCase {
        return DefaultFetchGenresUseCase(categoryRepository: categoryRepository)
    }
}

extension DIContainer{
    func buildModuleCoordinator(navigationController: UINavigationController) -> Coordinator {
        return CategoryCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DIContainer: CategoryCoordinatorDependencies {
    
    func buildCategoryViewController(coordinator: CategoryCoordinatorProtocol?) -> UIViewController {
         
        let categoryViewModel = CategoryViewModel(useCase: makeFetchGenresUseCase())
        categoryViewModel.coordinator = coordinator
        
        let categoryVC = CategoryViewController(viewModel: categoryViewModel)
        return categoryVC
    }
}
