//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .brown
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Saf")

        view.backgroundColor = .white
        view.backgroundColor = .darkGray
    }

}

