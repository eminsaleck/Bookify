//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation

enum CategoryViewState {
  case loading
  case populated
  case empty
  case error(String)
}

extension CategoryViewState: Equatable {

  static public func == (lhs: CategoryViewState, rhs: CategoryViewState) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading):
      return true
    case (.populated, .populated):
      return true
    case (.empty, .empty):
      return true
    case (.error, .error):
      return true
    default:
      return false
    }
  }
}
