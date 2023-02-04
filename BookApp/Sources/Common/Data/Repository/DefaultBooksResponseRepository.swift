//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Network
import Combine

public final class DefaultBooksRepository {
    private let booksRemoteDataSource: BooksRemoteDataSourceProtocol
    private let mapper: BooksMapperProtocol
    
    public init(booksRemoteDataSource: BooksRemoteDataSourceProtocol, mapper: BooksMapperProtocol) {
        self.booksRemoteDataSource = booksRemoteDataSource
        self.mapper = mapper
    }
}

extension DefaultBooksRepository: BooksRepository {
    public func fetchBooksByCategory(listName: String, date: String) -> AnyPublisher<BooksResponse, Network.DataTransferError> {
        return booksRemoteDataSource.fetchBooksByCategory(listName: listName, date: date)
            .map { self.mapper.mapCategory($0)
            }
            .eraseToAnyPublisher()
    }
    
}
