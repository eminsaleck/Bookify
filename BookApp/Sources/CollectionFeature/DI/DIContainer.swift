//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Common
import UI
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
    
    //MARK: - Build useCase
     func makeCollectionByCategoryUseCase(listName: String, date: String) -> FetchBooksUseCase {
        let booksRepository = DefaultBooksRepository(
            booksRemoteDataSource: DefaultBooksRemoteDataSource(dataTransferService: dependencies.apiDataTransferService),
            mapper: DefaultBooksMapper() )
        
        return DefaultFetchBooksByCategoryUseCase(
            listName: listName, date: date, booksRepository: booksRepository)
    }
}

extension DIContainer: CollectionCoordinatorDependencies {
    func buildcollectionViewController_ForCategory(with published: String, listName: String, coordinator: CollectionFeatureInterface.CollectionCoordinatorProtocol) -> UIViewController {       
      let viewModel = CollectionViewModel(useCase:  makeCollectionByCategoryUseCase(listName: listName, date: published))
      let collectionVC = CollectionViewController(viewModel: viewModel)
        collectionVC.navigationItem.title = Localized.book.localized()
      return collectionVC
    }
}
