//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Network
import Combine
import RealmSwift

public final class DefaultBooksRepository {
    private let booksRemoteDataSource: BooksRemoteDataSourceProtocol
    private let mapper: BooksMapperProtocol
    private let realmManager = RealmManager()

    public init(booksRemoteDataSource: BooksRemoteDataSourceProtocol, mapper: BooksMapperProtocol) {
        self.booksRemoteDataSource = booksRemoteDataSource
        self.mapper = mapper
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
                    let realm = try! Realm()
                    let booksResponseObject = realm.objects(CategoryBookObject.self).filter("listNameEncoded = '\(listName)'").first
                    if let object = booksResponseObject {
                        let booksResponse = self.realmManager.mapResults(object: object)
                        return Just(booksResponse)
                            .setFailureType(to: DataTransferError.self)
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: DataTransferError.noResponse)
                            .eraseToAnyPublisher()
                    }
                }
            .eraseToAnyPublisher()
        }
    }



