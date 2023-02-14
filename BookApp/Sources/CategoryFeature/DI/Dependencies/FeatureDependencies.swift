//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Network
import Common
import CollectionFeatureInterface
import Persistance


public struct FeatureDependencies {
    
    let apiDataTransferService: DataTransferServiceProtocol
    let collectionBuilder: ModuleCollectionBuilder
    let localStorage: LocalStorageProtocol
    
    public init(
        apiDataTransferService: DataTransferServiceProtocol,
        collectionBuilder: ModuleCollectionBuilder,
        localStorage: LocalStorageProtocol
    ){
        self.apiDataTransferService = apiDataTransferService
        self.collectionBuilder = collectionBuilder
        self.localStorage = localStorage
    }

}
