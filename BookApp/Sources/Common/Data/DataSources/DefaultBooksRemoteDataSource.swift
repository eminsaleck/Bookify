//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Combine
import NetworkManager
import Network

public final class DefaultBooksRemoteDataSource: BooksRemoteDataSourceProtocol {

  private let dataTransferService: DataTransferServiceProtocol

  public init(dataTransferService: DataTransferServiceProtocol) {
    self.dataTransferService = dataTransferService
  }

    public func fetchBooksByCategory(listName: String, date: String) -> AnyPublisher<BooksResponseDTO, DataTransferError> {
        let endpoint = Endpoint<BooksResponseDTO>(
          path: "/\(date)/\(listName).json",
          method: .get
        )
        return dataTransferService.request(with: endpoint).eraseToAnyPublisher()
    }

}
