//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Combine
import UI


final class CollectionRootView: UIView, UICollectionViewDelegate{
    
    private let viewModel: CollectionViewModelProtocol
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return collectionView
    }()
    private var detailLayout: HorizontalFlowLayout!

    typealias DataSource = UICollectionViewDiffableDataSource<CollectionSectionModel, CollectionCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionSectionModel, CollectionCellViewModel>
    private var dataSource: DataSource?
    
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init(frame: CGRect = .zero, viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        addSubview(collectionView)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        setupCollectionViewLayout()
        collectionView.delegate = self
        registerCell()
        setupDataSource()
        subscribe()
       // constrained()
    }
    
    private func registerCell(){
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: Constants.cellID)
    }
    
    private func setupCollectionViewLayout() {
        let detailLayoutWidth = collectionView.frame.width - Constants.detailCellOffset
        detailLayout = HorizontalFlowLayout(preferredWidth: detailLayoutWidth,
                                          preferredHeight: Constants.detailCellHeight)
        detailLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = detailLayout
    }

    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as! CollectionCell
            cell.setModel(viewModel: model)
            return cell
        }
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
        collectionView.frame = bounds
    }
    
}

extension CollectionRootView {

    struct Constants {
        static var cellID: String = "cell"
        
        static let detailCellHeight: CGFloat = 320
        static let detailCellOffset: CGFloat = -600

    }

}
