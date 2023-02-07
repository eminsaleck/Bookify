//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//


import UIKit
import Combine
import Common
import UI
import SafariServices


class CollectionViewController: UIViewController{
    
    private let viewModel: CollectionViewModelProtocol
    private var rootView: CollectionRootView?
    
    
    init(viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.viewDidLoad()
    }
    
    override func loadView() {
        rootView = CollectionRootView(viewModel: viewModel)
        rootView?.delegate = self
        view = rootView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel.viewDidFinish()
    }
}

extension CollectionViewController: CollectionRootDelegate{
    func collectionCellDidTapUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
