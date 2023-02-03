//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//


import Combine
import Network

protocol CategoryRepository {
  func categoryList() -> AnyPublisher<CategoryList, DataTransferError>
}
