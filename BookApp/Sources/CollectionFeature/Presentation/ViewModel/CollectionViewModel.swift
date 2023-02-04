//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import CollectionFeatureInterface
import Network
import UI
import Foundation
import Common
import Combine

final class CollectionViewModel: CollectionViewModelProtocol{
    
    var viewState: CurrentValueSubject<Common.SimpleViewState<CollectionCellViewModel>, Never> = .init(.loading)
    var bag = Set<AnyCancellable>()
    
    private weak var coordinator: CollectionCoordinatorProtocol?
    let useCase: FetchBooksUseCase
    
    var books: [BooksResponse.CategoryBook.Book]
    
    
    init(useCase: FetchBooksUseCase,
         coordinator: CollectionCoordinatorProtocol?
    ){
        self.useCase = useCase
        self.coordinator = coordinator
        self.books = []
    }
    
    func viewDidLoad() {
        getBooks()
    }
    
    func viewDidFinish() {
        coordinator?.navigate(with: .collectionDidFinish)
    }
    
    func mapToCell(entities: [BooksResponse.CategoryBook.Book]) -> [CollectionCellViewModel] {
        return entities.map { CollectionCellViewModel(book: $0)
        }
    }
    
    //MARK: - private
    private func getBooks() {
        useCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    print(error)
                case .finished: break
                }
            }, receiveValue: { [weak self] result in
                self?.processFetched(for: result.results)
            })
            .store(in: &bag)
    }
    
    private func processFetched(for response: BooksResponse.CategoryBook) {
        
        self.books.append(contentsOf: response.books)
        
        if self.books.isEmpty {
            viewState.send(.empty)
            return
        }
        
        let cellsBooks = mapToCell(entities: books)
        viewState.send( .populated(cellsBooks) )
    }
}
