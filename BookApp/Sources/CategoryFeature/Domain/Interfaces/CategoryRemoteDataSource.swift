//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Combine
import Network

public protocol CategoryRemoteDataSource {
  func fetchCategoryList() -> AnyPublisher<CategoryListDTO, DataTransferError>
}
