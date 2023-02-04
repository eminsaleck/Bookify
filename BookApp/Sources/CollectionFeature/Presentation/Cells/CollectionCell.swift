//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import UI

public class CollectionCell: UICollectionViewCell {
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let publisher: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let author: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var descriptions: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, author, publisher, descriptions, rankStackView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let starImageView: UIImageView = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .bold, scale: .large)
        let starFill = UIImage(systemName: "star.fill", withConfiguration: largeConfig)
        
        let imageView = UIImageView()
        imageView.image = starFill
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let rank: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var rankStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starImageView, rank])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5.0
        return stack
    }()
    
    private var gradientView = GradientView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    public func setModel(viewModel: CollectionCellViewModel) {
        imageView.setImage(viewModel.image)
        title.text = viewModel.title
        publisher.text = "Published by \(viewModel.publisher)"
        rank.text = String(viewModel.rank)
        descriptions.text = viewModel.description
        author.text = viewModel.author
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configUI() {
        backgroundColor = .secondarySystemBackground
       let _ = [imageView, gradientView, stackView].map { addSubview($0)}
        constrained()
    }

    private func constrained(){
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100),
            
        ])
    }
}
