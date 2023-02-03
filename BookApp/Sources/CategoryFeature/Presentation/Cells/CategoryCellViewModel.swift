//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common

protocol CategoryCellViewModelProtocol {
    var id: Int { get }
    var name: String { get }
}


final class CategoryCellViewModel: CategoryCellViewModelProtocol, Hashable {
  let id: Int
  let name: String
  private let category: Categoria

  public init(category: Categoria) {
    self.category = category
    id = category.id
    name = category.name
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: CategoryCellViewModel, rhs: CategoryCellViewModel) -> Bool {
    return lhs.id == rhs.id
  }
}
