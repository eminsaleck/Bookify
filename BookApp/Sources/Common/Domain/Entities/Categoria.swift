//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//


import Foundation

public struct Categoria: Hashable {
  
  public init(id: Int, name: String) {
      self.id = id
    self.name = name
  }
  
  public let id: Int
  public let name: String
}
