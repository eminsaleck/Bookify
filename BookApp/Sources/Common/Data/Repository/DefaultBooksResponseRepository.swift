//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Foundation
import Network
import Combine
import Persistance

public final class DefaultBooksRepository {
    private let booksRemoteDataSource: BooksRemoteDataSourceProtocol
    private let networkMapper: BooksMapperProtocol
    private let realmMapper: RealmMapperProtocol
    private let localDataSource: LocalStorageProtocol
    
    public init(booksRemoteDataSource: BooksRemoteDataSourceProtocol,
                networkMapper: BooksMapperProtocol,
                realmMapper: RealmMapperProtocol,
                localDataSource: LocalStorageProtocol
    ) {
        self.booksRemoteDataSource = booksRemoteDataSource
        self.networkMapper = networkMapper
        self.realmMapper = realmMapper
        self.localDataSource = localDataSource
    }
}

extension DefaultBooksRepository: BooksRepository {
    
    public func fetchBooksByCategory(listName: String, date: String) -> AnyPublisher<BooksResponse.CategoryBook, DataTransferError> {
        
        return booksRemoteDataSource.fetchBooksByCategory(listName: listName, date: date)
            .map { [weak self] booksResponse in
                let booksResponse = self?.networkMapper.mapCategory(booksResponse)
                self?.realmMapper.cache(booksResponse: booksResponse!)
                return booksResponse!.results
            }
            .catch { error ->  AnyPublisher<BooksResponse.CategoryBook, DataTransferError> in
                return self.localDataSource.fetch(ofType: CategoryBookObject.self, listName: listName)
                    .tryMap { object -> BooksResponse.CategoryBook in
                        if let object = object {
                            let booksResponse = self.realmMapper.mapResults(object: object)
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







