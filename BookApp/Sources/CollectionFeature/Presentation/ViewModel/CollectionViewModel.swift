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

    
    let useCase: FetchBooksUseCase
    
    init(useCase: FetchBooksUseCase){
        self.useCase = useCase
        
    }
    
    func viewDidLoad() {
        getBooks()
    }
    
    func willDisplayRow(_ row: Int, outOf totalRows: Int) {
        //
    }
    
    func showIsPicked(index: Int) {
        //
    }
    
    func refreshView() {
        //
    }
    
    func viewDidFinish() {
        //
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
            }, receiveValue: { result in
                print(result.results.books)
            })
            .store(in: &bag)
    }
}
