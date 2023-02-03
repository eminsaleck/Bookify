//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common

protocol CategoryCellViewModelProtocol {
    var listName: String { get }
    var displayName: String { get }
    var listNameEncoded: String { get }
    var oldestPublishedDate: String { get }
    var newestPublishedDate: String { get }
    var updated: Updated { get }
}


final class CategoryCellViewModel: CategoryCellViewModelProtocol, Hashable {
    var listName: String
    
    var displayName: String
    
    var listNameEncoded: String
    
    var oldestPublishedDate: String
    
    var newestPublishedDate: String
    
    var updated: Common.Updated
    
  private let category: CategoryList

  public init(category: CategoryList) {
    self.category = category
      listName = category.listName
      displayName = category.displayName
      listNameEncoded = category.listNameEncoded
      oldestPublishedDate = category.oldestPublishedDate
      newestPublishedDate = category.newestPublishedDate
      updated = category.updated
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(listNameEncoded)
  }

  static func == (lhs: CategoryCellViewModel, rhs: CategoryCellViewModel) -> Bool {
    return lhs.listNameEncoded == rhs.listNameEncoded
  }
}
