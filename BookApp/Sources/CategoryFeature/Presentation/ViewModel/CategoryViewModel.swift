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
final class CategoryViewModel: CategoryViewModelProtocol{
    
    weak var delegate: CategoryViewModelDelegate?
    
    weak var coordinator: CategoryCoordinatorProtocol?
    var useCase: FetchCategoryUseCase
    
    let viewState = CurrentValueSubject<CategoryViewState, Never>(.loading)
    let dataSource = CurrentValueSubject<[CategorySectionModel], Never>([])

    private var bag = Set<AnyCancellable>()

    init(useCase: FetchCategoryUseCase) {
        self.useCase = useCase
    }
    
    public func viewDidLoad() {
        fetch()
    }
 
    private func fetchCategories() -> AnyPublisher<CategoryResponse, ErrorEnvelope> {
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
              guard let self = self else { return }
                self.processFetched(for: result)
                self.createSectionModel(categories: result.results)

            })
            .store(in: &bag)
    }
    
    private func processFetched(for response: CategoryResponse) {
        let fetchedCategories = (response.results)
      if fetchedCategories.isEmpty {
        viewState.send(.empty)
      } else {
        viewState.send(.populated )
      }
    }
    
    private func createSectionModel(categories: [CategoryList]) {
        var sectionModel: [CategorySectionModel] = []
        
        let categorySectionItem = createSectionFor(categories: categories)

        if !categorySectionItem.isEmpty {
          sectionModel.append(.categories(items: categorySectionItem))
        }

        dataSource.send(sectionModel)
    }

    private func createSectionFor(categories: [CategoryList] ) -> [CategorySectionItem] {
      return categories
            .map {CategoryCellViewModel(category: $0)  }
        .map { CategorySectionItem.categories(items: $0) }
    }
    
    func modelIsPicked(with item: CategorySectionItem) {
        switch item {
        case .categories(items: let category):
            delegate?.categoryViewModel(self, didCategoryPicked: category.listNameEncoded, published: category.oldestPublishedDate)
        }
    }
    
}


