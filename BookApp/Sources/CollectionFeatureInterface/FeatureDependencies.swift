//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Network

public struct FeatureDependencies {

  public let apiDataTransferService: DataTransferServiceProtocol

  public init(apiDataTransferService: DataTransferServiceProtocol ){
    self.apiDataTransferService = apiDataTransferService
  }
}
