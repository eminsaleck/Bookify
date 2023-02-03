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

//final class CategoryViewModel: CategoryViewModelProtocol{
final class CategoryViewModel{
    
    weak var coordinator: CategoryCoordinatorProtocol?
    var useCase: FetchCategoryUseCase
    
    let viewState = CurrentValueSubject<CategoryViewState, Never>(.loading)

    private var disposeBag = Set<AnyCancellable>()


    init(useCase: FetchCategoryUseCase) {
        self.useCase = useCase
    
    }
    public func viewDidLoad() {
        fetch()
    }


 
     func fetchCategories() -> AnyPublisher<CategoryResponse, ErrorEnvelope> {
      return useCase.execute(requestValue: FetchCategoryUseCaseRequestValue())
        .mapError { error -> ErrorEnvelope in return ErrorEnvelope(transferError: error) }
        .eraseToAnyPublisher()
    }

    func fetch(){
        fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
              switch completion {
              case let .failure(error):
                  print(error)
              case .finished:
                break
              }
            },
                  receiveValue: { [weak self] result in
              guard let strongSelf = self else { return }
              strongSelf.processFetched(for: result)
                print(result.results)

            })
            .store(in: &disposeBag)
    }
    
    private func processFetched(for response: CategoryResponse) {
        let fetchedCategories = (response.results)
      if fetchedCategories.isEmpty {
        viewState.send(.empty)
      } else {
        viewState.send(.populated )
      }
    }
}


