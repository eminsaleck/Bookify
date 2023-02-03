//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Common
import UI

enum CategorySectionModel {
  case categories(items: [SearchSectionItem])

  var sectionView: CategorySectionView {
    switch self {
    case .categories:
      return .categories
    }
  }

  var items: [SearchSectionItem] {
    switch self {
    case let .categories(items):
      return items
    }
  }
}

enum CategorySectionView: Hashable {
  case categories

  var header: String? {
    switch self {
    case .categories:
      return Localized.categories.localized()
    }
  }
}

enum SearchSectionItem: Hashable {
  case categories(items: CategoryCellViewModel)
}
