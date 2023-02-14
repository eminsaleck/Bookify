//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//
import Foundation
import Combine
import Network
import NetworkManager
import Common
import Persistance

final class DefaultCategoryRepository {
    private let remoteDataSource: CategoryRemoteDataSource
    private let localDataSource: LocalStorageProtocol
    private var bag = Set<AnyCancellable>()
    
    init(remoteDataSource: CategoryRemoteDataSource, localDataSource: LocalStorageProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}

extension DefaultCategoryRepository: CategoryRepository {
    
    func categoryList() -> AnyPublisher<CategoryResponse, DataTransferError> {
        return remoteDataSource.fetchCategoryList()
            .map { [weak self] list in
                let categoryResponse = CategoryResponse(status: list.status,
                                                        copyright: list.copyright,
                                                        numResults: list.numResults,
                                                        results: list.results.map { CategoryList(listName: $0.listName,
                                                                                                 displayName: $0.displayName,
                                                                                                 listNameEncoded: $0.listNameEncoded,
                                                                                                 oldestPublishedDate: $0.oldestPublishedDate,
                                                                                                 newestPublishedDate: $0.newestPublishedDate,
                                                                                                 updated: $0.updated)
                })
                
                self?.cache(categoryResponse: categoryResponse)
                return categoryResponse
            }
            .catch { error -> AnyPublisher<CategoryResponse, DataTransferError> in
                return self.localDataSource.fetch(ofType: CategoryResponseObject.self)
                    .tryMap { categoryObject in
                        if let categoryObject = categoryObject {
                            let categoryResponse = CategoryResponse(status: categoryObject.status,
                                                                    copyright: categoryObject.copyright,
                                                                    numResults: categoryObject.numResults,
                                                                    results: categoryObject.results.map { categoryListObject in
                                CategoryList(listName: categoryListObject.listName,
                                             displayName: categoryListObject.displayName,
                                             listNameEncoded: categoryListObject.listNameEncoded,
                                             oldestPublishedDate: categoryListObject.oldestPublishedDate,
                                             newestPublishedDate: categoryListObject.newestPublishedDate,
                                             updated: categoryListObject.updated)
                            })
                            return categoryResponse
                        } else {
                            throw DataTransferError.noResponse
                        }
                    }
                    .subscribe(on: DispatchQueue.main)
                    .mapError { error in
                        return DataTransferError.noResponse
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func cache(categoryResponse: CategoryResponse) {
        let categoryResponseObject = CategoryResponseObject()
        categoryResponseObject.status = categoryResponse.status
        categoryResponseObject.copyright = categoryResponse.copyright
        categoryResponseObject.numResults = categoryResponse.numResults
        let categoryListObjects = categoryResponse.results
            .map { categoryList -> CategoryListObject in
                let categoryListObject = CategoryListObject()
                categoryListObject.listName = categoryList.listName
                categoryListObject.displayName = categoryList.displayName
                categoryListObject.listNameEncoded = categoryList.listNameEncoded
                categoryListObject.oldestPublishedDate = categoryList.oldestPublishedDate
                categoryListObject.newestPublishedDate = categoryList.newestPublishedDate
                (categoryListObject.updated = categoryList.updated)
                return categoryListObject
            }
        categoryResponseObject.results.append(objectsIn: categoryListObjects)
        
        localDataSource.save(object: categoryResponseObject)
            .subscribe(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("cache failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { _ in
                print("cached success")
                
            })
            .store(in: &bag)
    }
}


