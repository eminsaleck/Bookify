//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Combine
import Network

protocol FetchCategoryUseCase {
  func execute(requestValue: FetchCategoryUseCaseRequestValue) -> AnyPublisher<CategoryList, DataTransferError>
}

struct FetchCategoryUseCaseRequestValue { }

final class DefaultFetchGenresUseCase: FetchCategoryUseCase {

  private let categoryRepository: CategoryRepository

  init(categoryRepository: CategoryRepository) {
    self.categoryRepository = categoryRepository
  }

  func execute(requestValue: FetchCategoryUseCaseRequestValue) -> AnyPublisher<CategoryList, DataTransferError> {
      return categoryRepository.categoryList()
  }
}
