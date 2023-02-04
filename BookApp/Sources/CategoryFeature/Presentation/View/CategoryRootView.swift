//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit
import Combine
import UI

class CategoryRootView: UIView {
    
    private let viewModel: CategoryViewModelProtocol
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CategoryTableViewCell.self,
                           forCellReuseIdentifier: CellID.category.id)
        return tableView
    }()
    
    typealias DataSource = UITableViewDiffableDataSource<CategorySectionView, CategorySectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CategorySectionView, CategorySectionItem>
    private var dataSource: DataSource?
    
    private var bag = Set<AnyCancellable>()
    
    init(frame: CGRect = .zero, viewModel: CategoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(tableView)
        constrained()
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configUI() {
        tableView.delegate = self
        
        configDataSource()
        subscribe()
    }
    
    private func configDataSource() {
        tableView.delegate = self
        
        dataSource = UITableViewDiffableDataSource<CategorySectionView, CategorySectionItem>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, model in
            switch model {
            case .categories(items: let category):
                return self?.makeCellForCategory(tableView, at: indexPath, viewModel: category)
            }
        })
    }
    
    private func makeCellForCategory(_ tableView: UITableView, at indexPath: IndexPath, viewModel: CategoryCellViewModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.category.id, for: indexPath) as! CategoryTableViewCell
        
        cell.configViewModel(viewModel)
        return cell
    }
    
    private func constrained(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func subscribe() {
        viewModel.dataSource
            .map { dataSource -> Snapshot in
                var snapShot = Snapshot()
                for element in dataSource {
                    snapShot.appendSections([element.sectionView])
                    snapShot.appendItems(element.items, toSection: element.sectionView)
                }
                return snapShot
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] snapshot in
                self?.dataSource?.apply(snapshot)
            })
            .store(in: &bag)
    }
}


extension CategoryRootView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = dataSource?.itemIdentifier(for: indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            viewModel.modelIsPicked(with: model)
        }
    }

}
