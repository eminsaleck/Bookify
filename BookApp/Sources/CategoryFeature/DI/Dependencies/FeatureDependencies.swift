//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Network
//import Storage
import Common
import CollectionFeatureInterface

public struct FeatureDependencies {
    
    let apiDataTransferService: DataTransferServiceProtocol
    let collectionBuilder: ModuleCollectionBuilder
    
    public init(
        apiDataTransferService: DataTransferServiceProtocol,
        collectionBuilder: ModuleCollectionBuilder
    ){
        self.apiDataTransferService = apiDataTransferService
        self.collectionBuilder = collectionBuilder
    }

}
