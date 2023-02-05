//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Combine
import Network
import Common

public protocol CategoryRemoteDataSource {
  func fetchCategoryList() -> AnyPublisher<CategoryResponseDTO, DataTransferError>
}
