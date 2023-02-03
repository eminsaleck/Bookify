//
//  CategoryTableViewCell.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit
import Common
import UI

class CategoryTableViewCell: UITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    public var viewModel: CategoryCellViewModel?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViewModel(_ viewModel: CategoryCellViewModel) {
        self.viewModel = viewModel
        label.text = viewModel.displayName
    }
    
    private func configUI() {
        backgroundColor = .secondarySystemBackground
        contentView.addSubview(label)
        constructHierarchy()
        constrained()
    }
    
    private func constructHierarchy() {
    }
    
    private func constrained() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
