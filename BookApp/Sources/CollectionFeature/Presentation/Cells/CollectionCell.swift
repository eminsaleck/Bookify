//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import UI
import Combine

public class CollectionCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
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
    private let linksToBuy: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.text = Localized.linksToBuy.localized()
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
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rankStackView, title, author, publisher])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 20
        stack.bordered()
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
    private lazy var rank: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = .monospacedDigitSystemFont(ofSize: 18, weight: .heavy)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private lazy var rankStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rank, starImageView])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5.0
        return stack
    }()
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [descriptions])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 1.0
        stack.bordered()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var buyStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [linksToBuy, linskStackView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        stack.bordered()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var linskStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    weak var delegate: CollectionCellDelegate?
    private var bag = Set<AnyCancellable>()
    private var shopsSubject = PassthroughSubject<Set<[String: String]>, Never>()
    private var shops = Set<[String: String]>()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        subscribe()
    }
    public func setModel(viewModel: CollectionCellViewModel) {
        imageView.setImage(viewModel.image)
        title.text = viewModel.title
        publisher.text = "\(Localized.published.localized()) \(viewModel.publisher)"
        rank.text = String(viewModel.rank)
        descriptions.text = viewModel.description
        author.text = viewModel.author
        configRank(viewModel: viewModel)
        setLinks(viewModel: viewModel)
    }
    private func setLinks(viewModel: CollectionCellViewModel) {
        var newShops = Set<[String: String]>()
        viewModel.links.forEach { name in
            switch name.name {
            case .amazon:
                let dict = [name.name.rawValue: name.url]
                newShops.insert(dict)
            case .appleBooks:
                let dict = [name.name.rawValue: name.url]
                newShops.insert(dict)
            case .barnesAndNoble:
                let dict = [name.name.rawValue: name.url]
                newShops.insert(dict)
            case .booksAMillion:
                let dict = [name.name.rawValue: name.url]
                newShops.insert(dict)
            case .bookshop:
                let dict = [name.name.rawValue: name.url]
                newShops.insert(dict)
            case .indieBound:
                let dict = [name.name.rawValue: name.url]
                newShops.insert(dict)
            }
        }
        shops = newShops
        shopsSubject.send(shops)
    }
    private func subscribe() {
        shopsSubject
            .sink(receiveValue: { [weak self] shops in
                self?.linskStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
                shops.forEach { dict in
                    dict.forEach { name, url in
                        let button = SubButton(type: .system)
                        button.setTitle(name, for: .normal)
                        button.setTitleColor(.blue, for: .normal)
                        button.url = url
                        button.addTarget(self, action: #selector(self?.handleShopButtonTapped(sender:)), for: .touchUpInside)
                        self?.linskStackView.addArrangedSubview(button)
                    }
                }
            })
            .store(in: &bag)
    }
    
    @objc private func handleShopButtonTapped(sender: SubButton) {
        guard let url = sender.url else { return }
        delegate?.collectionCellDidTapUrl(url)
    }
    
    private func configShop(shop: String) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = shop
        return label
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configRank(viewModel: CollectionCellViewModel){
        if viewModel.rank >= 7 {
            rank.textColor = .systemGreen
        } else if viewModel.rank >= 5 {
            rank.textColor = .yellow
        } else if viewModel.rank >= 3 {
            rank.textColor = .systemOrange
        } else if viewModel.rank < 3 {
            rank.textColor = .systemRed
        }
    }
    
    private func configUI() {
        backgroundColor = .clear
        let _ = [imageView, topStackView, bottomStackView, buyStackView].map { addSubview($0)}
        
        constrained()
        layer.bordered()
    }
    
    
    private func constrained(){
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 210),
            
            topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            topStackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5),
            topStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            topStackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bottomStackView.heightAnchor.constraint(equalToConstant: 100),
            
            buyStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buyStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buyStackView.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor),
            buyStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
