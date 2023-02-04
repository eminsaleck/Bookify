//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Combine
import UI


final class CollectionRootView: UIView, UITableViewDelegate{
    
    private let viewModel: CollectionViewModelProtocol
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CollectionCell.self, forCellReuseIdentifier: CellID.list.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .automatic
        return tableView
    }()
    
    typealias DataSource = UITableViewDiffableDataSource<CollectionSectionModel, CollectionCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionSectionModel, CollectionCellViewModel>
    private var dataSource: DataSource?
    
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init(frame: CGRect = .zero, viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(tableView)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        tableView.delegate = self
        setupDataSource()
        subscribe()
    }

    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.list.id, for: indexPath) as! CollectionCell
            cell.setModel(viewModel: model)
            return cell
        })
    }
    
    private func subscribe() {
        viewModel
            .viewState
            .map { viewState -> Snapshot in
                var snapShot = Snapshot()
                snapShot.appendSections([.list])
                snapShot.appendItems(viewState.currentEntities, toSection: .list)
                return snapShot
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] snapshot in
                self?.dataSource?.apply(snapshot)
            })
            .store(in: &disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
}
