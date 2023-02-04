//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Combine
import Common
import Network

final class DefaultFetchBooksByCategoryUseCase: FetchBooksUseCase {
    private let listName: String
    private let date: String
    private let booksRepository: BooksRepository
    
    init(listName: String, date: String, booksRepository: BooksRepository) {
        self.listName = listName
        self.date = date
        self.booksRepository = booksRepository
    }
    
    func execute() -> AnyPublisher<BooksResponse, DataTransferError> {
        return booksRepository.fetchBooksByCategory(listName: listName, date: date)
    }
}


