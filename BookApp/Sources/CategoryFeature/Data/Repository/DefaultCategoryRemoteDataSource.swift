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


final public class DefaultCategoryRemoteDataSource: CategoryRemoteDataSource{
    
    private let dataTransferService: DataTransferServiceProtocol

    init(dataTransferService: DataTransferServiceProtocol) {
      self.dataTransferService = dataTransferService
    }

     public func fetchCategoryList() -> AnyPublisher<CategoryResponseDTO, DataTransferError> {
      let endpoint = Endpoint<CategoryResponseDTO>(
        path: "names.json",
        method: .get
      )
      return dataTransferService.request(with: endpoint)
    }
}
