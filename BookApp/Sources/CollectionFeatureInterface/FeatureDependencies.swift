//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 04.02.2023.
//

import UIKit
import Persistance
import Network

public struct FeatureDependencies {

  public let apiDataTransferService: DataTransferServiceProtocol
    public let localStorage: LocalStorageProtocol

  public init(apiDataTransferService: DataTransferServiceProtocol,
              localStorage: LocalStorageProtocol
  ){
    self.apiDataTransferService = apiDataTransferService
    self.localStorage = localStorage
  }
}
