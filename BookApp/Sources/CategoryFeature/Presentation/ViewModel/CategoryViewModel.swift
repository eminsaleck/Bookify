//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Combine
import Common
import Network

final class CategoryViewModel{
    
    weak var coordinator: CategoryCoordinatorProtocol?
    var useCase: FetchCategoryUseCase
    
    let viewState = CurrentValueSubject<CategoryViewState, Never>(.loading)
    let dataSource = CurrentValueSubject<[CategorySectionModel], Never>([])

    private var disposeBag = Set<AnyCancellable>()


    init(useCase: FetchCategoryUseCase) {
        self.useCase = useCase
    }

    private func fetchCategories() -> AnyPublisher<CategoryList, ErrorEnvelope> {
      return useCase.execute(requestValue: FetchCategoryUseCaseRequestValue())
        .mapError { error -> ErrorEnvelope in return ErrorEnvelope(transferError: error) }
        .eraseToAnyPublisher()
    }
}
