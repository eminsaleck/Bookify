//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import CollectionFeatureInterface

protocol CollectionCoordinatorDependencies {
    func buildcollectionViewController_ForCategory(with published: String, listName: String,
                                             coordinator: CollectionCoordinatorProtocol) -> UIViewController
}
