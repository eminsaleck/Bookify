//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Foundation

public protocol BooksMapperProtocol {
  func mapCategory(_ category: BooksResponseDTO) -> BooksResponse
}
