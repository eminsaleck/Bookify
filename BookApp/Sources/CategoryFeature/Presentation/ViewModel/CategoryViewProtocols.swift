//
//  File.swift
//
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Combine

protocol CategoryViewModelDelegate: AnyObject {
    func categoryViewModel(_ categoryViewModel: CategoryViewModel,
                           didCategoryPicked listName: String,
                           published: String)
}
protocol CategoryViewModelProtocol {
  // MARK: - Input
  func viewDidLoad()
  func modelIsPicked(with item: CategorySectionItem)

  // MARK: - Output
  var viewState: CurrentValueSubject<CategoryViewState, Never> { get }
  var dataSource: CurrentValueSubject<[CategorySectionModel], Never> { get }
}
