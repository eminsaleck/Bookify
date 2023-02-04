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
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
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
        topLabel.text = viewModel.displayName
        bottomLabel.text = viewModel.years
    }
    
    private func configUI() {
        backgroundColor = .secondarySystemBackground
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        constrained()
    }
    
    private func constrained() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
        ])
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30),
            bottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
