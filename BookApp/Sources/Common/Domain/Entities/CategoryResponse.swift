//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 03.02.2023.
//

import Foundation

public struct CategoryResponse {
    public let status: String
    public let copyright: String
    public let numResults: Int
    public let results: [CategoryList]
    public init(status: String, copyright: String, numResults: Int, results: [CategoryList]) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}
