//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Combine
import Network
import NetworkManager
import Common

final class DefaultCategoryRepository {
  private let remoteDataSource: CategoryRemoteDataSource

  init(remoteDataSource: CategoryRemoteDataSource) {
    self.remoteDataSource = remoteDataSource
  }
}

extension DefaultCategoryRepository: CategoryRepository {

    func categoryList() -> AnyPublisher<CategoryResponse, DataTransferError> {
        return remoteDataSource.fetchCategoryList()
            .map { list in
                let results = list.results.map { CategoryList(listName: $0.listName,
                                                             displayName: $0.displayName,
                                                             listNameEncoded: $0.listNameEncoded,
                                                             oldestPublishedDate: $0.oldestPublishedDate,
                                                             newestPublishedDate: $0.newestPublishedDate,
                                                             updated: $0.updated)
                }
                return CategoryResponse(status: list.status,
                                        copyright: list.copyright,
                                        numResults: list.numResults,
                                        results: results)
            }.eraseToAnyPublisher()
    }
}
