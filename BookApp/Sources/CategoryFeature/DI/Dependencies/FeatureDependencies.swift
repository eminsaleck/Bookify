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
//import ListFeatureInterface

public struct FeatureDependencies {
    
    let apiDataTransferService: DataTransferServiceProtocol
    
    public init(apiDataTransferService: DataTransferServiceProtocol){
        self.apiDataTransferService = apiDataTransferService
    }

}
