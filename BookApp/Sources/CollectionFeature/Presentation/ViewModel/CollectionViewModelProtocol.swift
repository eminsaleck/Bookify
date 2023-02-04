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
  func viewDidFinish()

  // MARK: - Output
    var viewState: CurrentValueSubject<SimpleViewState<CollectionCellViewModel>, Never> { get }
}

