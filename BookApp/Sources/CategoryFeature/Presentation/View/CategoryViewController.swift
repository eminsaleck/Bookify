//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit
import UI
import Combine

class CategoryViewController: UIViewController, Loadable {
    
    private let viewModel: CategoryViewModelProtocol
    private var rootView: CategoryRootView?
    private var bag = Set<AnyCancellable>()
    private let errorView = ErrorView(frame: .zero)

    
    init(viewModel: CategoryViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
      rootView = CategoryRootView(viewModel: viewModel)
      view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        bindViewState()
        viewModel.viewDidLoad()
    }
    
    private func configViews() {
      errorView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }
    
    private func bindViewState() {
      viewModel.viewState
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] viewState in
          self?.handleTableState(with: viewState)
        })
        .store(in: &bag)
    }
    
    private func handleTableState(with state: CategoryViewState) {
      hideLoadingView()

      switch state {
      case .loading:
        showLoadingView()
        rootView?.tableView.tableFooterView = nil
        rootView?.tableView.separatorStyle = .none

      case .populated:
        rootView?.tableView.tableFooterView = nil
        rootView?.tableView.separatorStyle = .singleLine

      case .empty:
          
          errorView.messageLabel.text = "No category to Show"
        rootView?.tableView.tableFooterView = errorView
        rootView?.tableView.separatorStyle = .none

      case .error(let error):
          errorView.messageLabel.text = error
        rootView?.tableView.tableFooterView = errorView
        rootView?.tableView.separatorStyle = .none
      }
    }
}

