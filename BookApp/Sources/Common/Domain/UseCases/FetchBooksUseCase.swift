//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Combine
import Network

public protocol FetchBooksUseCase {
  func execute() -> AnyPublisher<BooksResponse, DataTransferError>
}

