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
    private let realmMapper: RealmMapperProtocol
    
    private var bag = Set<AnyCancellable>()
    
    init(remoteDataSource: CategoryRemoteDataSource,
         localDataSource: LocalStorageProtocol,
         realmMapper: RealmMapperProtocol
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        self.realmMapper = realmMapper
    }
}

extension DefaultCategoryRepository: CategoryRepository {
    
    func categoryList() -> AnyPublisher<CategoryResponse, DataTransferError> {
        return remoteDataSource.fetchCategoryList()
            .map { [weak self] list in
                let categoryResponse = self?.mapDTO(list: list)
                self?.cache(categoryResponse: categoryResponse!)
                return categoryResponse!
            }
            .catch { error -> AnyPublisher<CategoryResponse, DataTransferError> in
                return self.localDataSource.fetch(ofType: CategoryResponseObject.self)
                    .tryMap { categoryObject in
                        if let object = categoryObject {
                            return try self.realmMapper.mapCategoryObject(categoryObject: object)
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
        let categoryResponseObject = realmMapper.map(categoryResponse: categoryResponse)
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
    
    private func mapDTO(list: CategoryResponseDTO) -> CategoryResponse{
        let categoryResponse = CategoryResponse(status: list.status,
                                                copyright: list.copyright,
                                                numResults: list.numResults,
                                                results: list.results.map {
            CategoryList(listName: $0.listName,
            displayName: $0.displayName,
            listNameEncoded: $0.listNameEncoded,
            oldestPublishedDate: $0.oldestPublishedDate,
            newestPublishedDate: $0.newestPublishedDate,
            updated: $0.updated)
        })
        return categoryResponse
    }
}


