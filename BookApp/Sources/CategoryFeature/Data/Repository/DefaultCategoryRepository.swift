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

  func categoryList() -> AnyPublisher<CategoryList, DataTransferError> {
      return remoteDataSource.fetchCategoryList()
      .map { list in
          let categoryDomain = list.categories.map { Categoria(id: $0.id, name: $0.name) }
        return CategoryList(categories: categoryDomain)
      }
      .eraseToAnyPublisher()
  }
}
