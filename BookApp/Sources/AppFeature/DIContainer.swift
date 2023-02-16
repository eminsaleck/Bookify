//
//  DIContainer.swift
//
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation
import Common
import Network
import CategoryFeature
import UI
import NetworkManager
import CollectionFeatureInterface
import CollectionFeature
import UIKit
import Persistance

public class DIContainer {
    private let appConfigurations: AppConfigurationProtocol
    private let language: Language

    private lazy var apiDataTransferService: DataTransferServiceProtocol = {
        let queryParameters = [
            "api-key": appConfigurations.apiKey
        ]
        let configuration = ApiDataNetworkConfig(
            baseURL: appConfigurations.apiBaseURL,
            headers: [
                "Content-Type": "application/json; charset=utf-8"
            ],
            queryParameters: queryParameters
        )
        let networkService = NetworkService(config: configuration)
        return DataTransferService(with: networkService)
    }()
    private lazy var localStorage: LocalStorage = {
        return LocalStorage()
    }()
    public init(appConfigurations: AppConfigurationProtocol) {
        self.appConfigurations = appConfigurations
        language = Language(languageStrings: Locale.preferredLanguages) ?? .eng
        Localized.currentLocale = Locale(identifier: language.rawValue)
    }
}

extension DIContainer {
    func buildCategoryModule() -> CategoryFeature.Module {
        let dependencies = CategoryFeature.FeatureDependencies(
            apiDataTransferService: apiDataTransferService,
            collectionBuilder: self, localStorage: localStorage)
        return CategoryFeature.Module(dependencies: dependencies)
    }
}

extension DIContainer: ModuleCollectionBuilder {
    public func buildModuleCoordinator(in navigationController: UINavigationController,
                                       delegate: CollectionCoordinatorDelegate?) -> CollectionCoordinatorProtocol {
        let dependencies = CollectionFeatureInterface
            .FeatureDependencies(apiDataTransferService: apiDataTransferService, localStorage: localStorage)
        let module = CollectionFeature.Module(dependencies: dependencies)
        return module.buildModuleCoordinator(in: navigationController, delegate: delegate)
    }
}
