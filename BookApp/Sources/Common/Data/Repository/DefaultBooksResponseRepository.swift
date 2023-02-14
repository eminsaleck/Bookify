//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Foundation
import Network
import Combine
import RealmSwift
import Persistance

public final class DefaultBooksRepository {
    private let booksRemoteDataSource: BooksRemoteDataSourceProtocol
    private let mapper: BooksMapperProtocol
    private let realmManager = RealmManager()
    private let localDataSource: LocalStorageProtocol
    
    public init(booksRemoteDataSource: BooksRemoteDataSourceProtocol,
                mapper: BooksMapperProtocol,
                localDataSource: LocalStorageProtocol
    ) {
        self.booksRemoteDataSource = booksRemoteDataSource
        self.mapper = mapper
        self.localDataSource = localDataSource
    }
}

extension DefaultBooksRepository: BooksRepository {
    
    public func fetchBooksByCategory(listName: String, date: String) -> AnyPublisher<BooksResponse.CategoryBook, DataTransferError> {
        
        return booksRemoteDataSource.fetchBooksByCategory(listName: listName, date: date)
            .map { [weak self] booksResponse in
                let booksResponse = self?.mapper.mapCategory(booksResponse)
                self?.realmManager.cache(booksResponse: booksResponse!)
                return booksResponse!.results
            }
            .catch { error ->  AnyPublisher<BooksResponse.CategoryBook, DataTransferError> in
                return self.localDataSource.fetch(ofType: CategoryBookObject.self, listName: listName)
                    .tryMap { object -> BooksResponse.CategoryBook in
                        if let object = object {
                            let booksResponse = self.realmManager.mapResults(object: object)
                            return booksResponse
                        } else {
                            throw DataTransferError.noResponse
                        }
                    }
                    .subscribe(on: DispatchQueue.main)
                    .mapError { error -> DataTransferError in
                        switch error {
                        case is DataTransferError:
                            return error as! DataTransferError
                        default:
                            return DataTransferError.noResponse
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}







