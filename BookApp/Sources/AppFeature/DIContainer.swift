//
//  DIContainer.swift
//
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import CategoryFeature
import UI


public class DIContainer {
    
    private let appConfigurations: AppConfigurationProtocol
    
    private let language: Language

    
    public init(appConfigurations: AppConfigurationProtocol) {
        self.appConfigurations = appConfigurations
        
        language = Language(languageStrings: Locale.preferredLanguages) ?? .en
        Localized.currentLocale = Locale(identifier: language.rawValue)
    }
}

extension DIContainer{
    func buildCategoryModule() -> CategoryFeature.Module {
        let dependencies = CategoryFeature.FeatureDependencies()
        return CategoryFeature.Module(dependencies: dependencies)
    }
}
