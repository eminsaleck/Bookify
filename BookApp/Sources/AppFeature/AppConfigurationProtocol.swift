//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation

public protocol AppConfigurationProtocol {
  var apiKey: String { get set }
  var apiBaseURL: URL { get set }
}
