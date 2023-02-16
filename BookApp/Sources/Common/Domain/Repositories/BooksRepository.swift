//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Combine
import Network

public protocol BooksRepository {
    func fetchBooksByCategory(
        listName: String, date: String) -> AnyPublisher<BooksResponse.CategoryBook, DataTransferError>
}
