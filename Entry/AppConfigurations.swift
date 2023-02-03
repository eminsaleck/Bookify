//
//  AppConfigurations.swift
//  Entry
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import AppFeature
import Foundation

final class AppConfigurations: AppConfigurationProtocol {
    
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseURL: URL = {
        guard let apiBaseString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        
        guard let apiBaseURL = URL(string: apiBaseString) else {
            fatalError("Could not convert \(apiBaseString) into a URL")
        }
        
        return apiBaseURL
    }()
}
