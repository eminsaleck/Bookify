//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//


import UIKit

class CollectionViewController: UIViewController{
    
  let viewModel: CollectionViewModelProtocol
    
    init(viewModel: CollectionViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.viewDidLoad()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
      viewModel.viewDidFinish()
      print("deinit \(Self.self)")
    }
    
    //MARK: - Private

}
