//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation


public struct CategoriaDTO: Decodable {
  public let id: Int
  public let name: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
}
