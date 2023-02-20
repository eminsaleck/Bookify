//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 14.02.2023.
//

import Foundation
import RealmSwift
import Combine
import Network

public protocol LocalStorageProtocol {
    func fetch<T: Object>(ofType type: T.Type) -> AnyPublisher<T?, DataTransferError>
    func save<T: Object>(object: T) -> AnyPublisher<Void, DataTransferError>
    func fetch<T: Object>(ofType type: T.Type, listName: String) -> AnyPublisher<T?, DataTransferError>
}

public final class LocalStorage: LocalStorageProtocol {
    private let realmStorage: RealmStorage

    public init(realmStorage: RealmStorage) {
      self.realmStorage = realmStorage
    }
    
    public func fetch<T: Object>(ofType type: T.Type) -> AnyPublisher<T?, DataTransferError> {
        return Deferred {
            Future { promise in
                let object = self.realmStorage.realm.objects(T.self).first
                promise(.success(object))
            }
        }.eraseToAnyPublisher()
    }
    public func fetch<T: Object>(ofType type: T.Type, listName: String) -> AnyPublisher<T?, DataTransferError> {
        return Deferred {
            Future { promise in
                let object = self.realmStorage.realm.objects(T.self).filter("listNameEncoded = '\(listName)'").first
                promise(.success(object))
            }
        }.eraseToAnyPublisher()
    }
    public func save<T: Object>(object: T) -> AnyPublisher<Void, DataTransferError> {
        return Deferred {
            Future { promise in
                do {
                    try self.realmStorage.realm.write {
                        self.realmStorage.realm.add(object, update: .modified)
                    }
                    promise(.success(()))
                } catch let error as DataTransferError {
                    promise(.failure(error))
                } catch {
                    let error = DataTransferError.noResponse
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
