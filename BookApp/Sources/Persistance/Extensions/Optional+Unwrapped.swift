//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 14.02.2023.
//

import Foundation

public extension Optional where Wrapped == LocalStorage {
    func unwrapped() throws -> LocalStorage {
        guard let storage = self else {
            throw fatalError()
        }
        return storage
    }
}
