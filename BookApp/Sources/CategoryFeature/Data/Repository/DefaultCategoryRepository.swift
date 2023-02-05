//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Combine
import Network
import NetworkManager
import Common
import RealmSwift

final class DefaultCategoryRepository {
    private let remoteDataSource: CategoryRemoteDataSource
    
    init(remoteDataSource: CategoryRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
}

extension DefaultCategoryRepository: CategoryRepository {
    
    func categoryList() -> AnyPublisher<CategoryResponse, DataTransferError> {
        let realm = try! Realm()
        let categoryObject = realm.objects(CategoryResponseObject.self).first
        
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
            return Just(categoryResponse)
                .setFailureType(to: DataTransferError.self)
                .eraseToAnyPublisher()
        } else {
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
                .eraseToAnyPublisher()
        }
    }
    
    private func cache(categoryResponse: CategoryResponse) {
        let realm = try! Realm()
        try! realm.write {
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
            realm.add(categoryResponseObject)
        }
    }
}
