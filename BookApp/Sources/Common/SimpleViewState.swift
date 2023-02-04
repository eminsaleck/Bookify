//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//


import Foundation

public enum SimpleViewState<Entity: Equatable> {
  case loading
  case populated([Entity])
  case empty
  case error(String)

  public var currentEntities: [Entity] {
    switch self {
    case .populated(let entities):
      return entities
    case .loading, .empty, .error:
      return []
    }
  }

}

extension SimpleViewState: Equatable {

  static public func == (lhs: SimpleViewState<Entity>, rhs: SimpleViewState<Entity>) -> Bool {
    switch (lhs, rhs) {
    case (.loading, .loading):
      return true
    case (let .populated(lhShows), let .populated(rhShows)):
      return lhShows == rhShows

    case (.empty, .empty):
      return true
    case (.error, .error):
      return true

    default:
      return false
    }
  }
}
