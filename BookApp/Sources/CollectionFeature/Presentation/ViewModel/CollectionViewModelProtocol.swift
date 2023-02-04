//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import Combine
import Common

protocol CollectionViewModelProtocol {
  // MARK: - Input
  func viewDidLoad()
  func willDisplayRow(_ row: Int, outOf totalRows: Int)
  func showIsPicked(index: Int)
  func refreshView()
  func viewDidFinish()

  // MARK: - Output
    var viewState: CurrentValueSubject<SimpleViewState<CollectionCellViewModel>, Never> { get }
}
