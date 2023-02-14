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
}

public class LocalStorage: LocalStorageProtocol {
    private let realm: Realm
    
    public init() {
        self.realm = try! Realm()
        
    }
    
    public func fetch<T: Object>(ofType type: T.Type) -> AnyPublisher<T?, DataTransferError> {
        return Deferred {
            Future { promise in
                    let object = self.realm.objects(T.self).first
                    promise(.success(object))
            }
        }.eraseToAnyPublisher()
    }
    
    public func save<T: Object>(object: T) -> AnyPublisher<Void, DataTransferError> {
        return Deferred {
            Future { promise in
                do {
                    try self.realm.write {
                        self.realm.add(object, update: .modified)
                    }
                    promise(.success(()))
                } catch {
                    promise(.failure(error as! DataTransferError))
                }
            }
        }.eraseToAnyPublisher()
    }
}

